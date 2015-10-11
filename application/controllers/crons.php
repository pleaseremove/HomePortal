<?php

class Crons extends CI_Controller {
	
	private $contacts = array();
	private $current_messages = array();
	
	public function __construct(){
		parent::__construct();
	}
	
	function run_crons(){
		$this->event_alerts();
		$this->import_sms();
	}
	
	function event_alerts(){
		$this->load->library('email',array('mailtype'=>'html'));
		
		$this->email->from($this->site->email->default_from, 'Home Portal');
		$this->email->subject('HomePortal - Reminders: '.date('D jS'));
		
		//fetch all the users who want this
		$users = $this->load->activeModelReturn('model_users',array(NULL,'WHERE email_alerts = 1 AND email IS NOT NULL'));
		
		foreach($users as $user){
			//first get their calendar events for today
			$this->load->activeModel('model_calendar_events','events_list',array(NULL,'WHERE start_date = DATE(NOW()) AND (private = 0 OR created_by = '.$user->id().') AND family_id = '.$user->family_id));
			
			//then get up and coming birthdays and aniversaries
			//user $user->reminder_days for bithdays query too
			$this->load->activeModel('model_calendar_events','banda_list',array(NULL,NULL,"
				SELECT * FROM
				(
					(
						SELECT
							first_name,last_name,
							DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthday, '%Y') + IF(DATE_FORMAT(birthday, '%m%d') < DATE_FORMAT(NOW(), '%m%d'), 1, 0) AS new_age,
							DATEDIFF(birthday + INTERVAL YEAR(NOW()) - YEAR(birthday) + IF(DATE_FORMAT(NOW(), '%m%d') > DATE_FORMAT(birthday, '%m%d'), 1, 0) YEAR, NOW()) AS days_to_event,
							'b' AS event_type,
							birthday as event_date
						FROM contacts_main
						WHERE (private = 0 OR created_by = ".$user->id().") AND family_id = ".$user->family_id." AND deleted = 0
						HAVING days_to_event <= ".$user->reminder_days."
						ORDER BY days_to_event ASC
					)UNION(
						SELECT
							first_name,last_name,
							DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(aniversary, '%Y') + IF(DATE_FORMAT(aniversary, '%m%d') < DATE_FORMAT(NOW(), '%m%d'), 1, 0) AS new_age,
							DATEDIFF(aniversary + INTERVAL YEAR(NOW()) - YEAR(aniversary) +	IF(DATE_FORMAT(NOW(), '%m%d') > DATE_FORMAT(aniversary, '%m%d'), 1, 0) YEAR, NOW()) AS days_to_event,
							'a' AS event_type,
							aniversary as event_date
						FROM contacts_main
						WHERE (private = 0 OR created_by = ".$user->id().") AND family_id = ".$user->family_id." AND deleted = 0
						HAVING days_to_event <= ".$user->reminder_days."
						ORDER BY days_to_event ASC
					)
				)AS data_set
				ORDER BY days_to_event"));
			
			//then get up and coming tasks (due in the next X days)
			$this->load->activeModel('model_tasks','tasks_list',array(NULL,'WHERE date_due <= DATE_ADD(NOW(), INTERVAL '.$user->reminder_days.' DAY) AND date_due >=NOW() AND completed = 0 AND (private = 0 OR user_created = '.$user->id().') AND family_id = '.$user->family_id));
			
			if($this->tasks_list->num_rows()>0 || $this->events_list->num_rows()>0 || $this->banda_list->num_rows()>0){
				
				//run the template and return that to the email body
				$this->email->to($user->email);
				$this->email->message($this->mysmarty->view('emails/daily_update',false,true));
			
				//send the e-amil
				$this->email->send();
			
			}
			
		}
		
	}
	
	function import_sms(){
		//get all users with sms import turned on
		$users = $this->load->activeModelReturn('model_users',array(NULL,NULL,'SELECT u.*, (SELECT COUNT(*) FROM contacts_sms WHERE user_id = u.users_id) as sms_count FROM users AS u WHERE sms_import = 1'));
		
		$this->load->helper('file');
		
		foreach($users as $u){
			//find the file
			$file = read_file($this->site->files->sms.$u->username.'/smsarchive.xml');
			
			//if it is there read it in
			if($file){
				$xml = simplexml_load_string($file);
				
				//check there is something worth importing
				if((int) $xml->attributes()->count > (int) $u->sms_count){
					
					//load in what we have in the db
					$this->fetch_current_messages($u->id());
					
					foreach($xml->sms as $sms){
							
						$sms_data = (array) $sms;
						$sms_data = $sms_data['@attributes'];
						
						$contact_id = $this->get_contact($sms_data['address']);
						
						if($contact_id){
							
							switch($sms_data['type']){
								case '1':
									$status = 'received';
									break;
								case '2':
									$status = 'sent';
									break;
								case '3':
									$status = 'draft';
									break;
								case '4':
									$status = 'outbox';
									break;
								case '5':
									$status = 'failed';
									break;
								case '6':
									$status = 'queued';
									break;
							}
							
							$message_unix = intval($sms_data['date']/1000);
							
							echo 'testing: '.$message_unix.'-'.$status.$u->id().$contact_id.'|';
							
							if(!array_key_exists($message_unix.'-'.$status.$u->id().$contact_id,$this->current_messages)){
								$db_sms = $this->load->activeModelReturn('model_contacts_sms',array(0));
								$db_sms->contact_id = $contact_id;
								$db_sms->user_id = $u->id();
								$db_sms->received_sent = $status;
								$db_sms->datetime = date('Y-m-d H:i:s',$message_unix);
								$db_sms->message = $sms_data['body'];
								$db_sms->save();
							}
						}
					}
				}
				
			}
		}
	}
	
	function get_contact($original_number){
		
		$original_number = trim($original_number);
		
		if(isset($this->contacts[$original_number])){
			return $this->contacts[$original_number];
		}
		
		//otherwise clean the number up and go find it
		$number = str_replace('+44','0',$original_number);
		
		$contact = $this->load->activeModelReturn('model_contacts_data',array(NULL,'WHERE data = '.$this->db->escape($number).' LIMIT 1'));
		
		if(count($contact)==1){
			$this->contacts[$original_number] = $contact->contact_id;
			return $contact->contact_id;
		}else{
			echo 'failed to fine the number: '+$number;
			return false;
		}
		
	}
	
	function fetch_current_messages($user_id){
		
		//need to clean the array out in for multiple users
		$this->current_messages = array();
		
		$messages = $this->load->activeModelReturn('model_contacts_sms',array(NULL,NULL,'select concat(UNIX_TIMESTAMP(`datetime`),\'-\',received_sent,user_id,contact_id) as unique_id from contacts_sms where user_id = '.$user_id));
		
		foreach($messages as $m){
			$this->current_messages[$m->unique_id] = true;
		}
		
		print_r($this->current_messages);
	}
}

?>
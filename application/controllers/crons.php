<?php

class Crons extends CI_Controller {
	
	public function __construct(){
		parent::__construct();
	}
	
	function run_crons(){
		$this->event_alerts();
	}
	
	function event_alerts(){
		$this->load->library('email',array('mailtype'=>'html'));
		
		$this->email->from('homeportal@server', 'Home Portal');
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
}

?>
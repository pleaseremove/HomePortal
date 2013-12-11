<?php

class Dashboard extends My_Controller {

	function index(){
		if($this->input->post('is_ajax',false)){
			$this->overview();
		}else{
			$this->overview_data();
			$this->mysmarty->view('index');
		}
	}
	
	function overview(){
		$this->overview_data();
		$this->json->setData($this->mysmarty->view('overview',false,true));
		$this->json->outputData();
	}
	
	private function overview_data(){
		
		//birthdays and anniversaries
		$this->mysmarty->assign('bsandas',$this->load->activeModelReturn('model_contacts_main',array(NULL,NULL,
			"SELECT * FROM
				(
					(
						SELECT
							CONCAT(first_name,' ',last_name) as name,
							DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthday, '%Y') + IF(DATE_FORMAT(birthday, '%m%d') < DATE_FORMAT(NOW(), '%m%d'), 1, 0) AS new_age,
							DATEDIFF(birthday + INTERVAL YEAR(NOW()) - YEAR(birthday) + IF(DATE_FORMAT(NOW(), '%m%d') > DATE_FORMAT(birthday, '%m%d'), 1, 0) YEAR, NOW()) AS days_to_event,
							'b' AS event_type,
							birthday as event_date,
							contact_id AS contact
						FROM contacts_main
						WHERE (private = 0 OR created_by = ".$this->mylogin->user()->id().") AND family_id = ".$this->mylogin->user()->family_id." AND deleted = 0
						HAVING days_to_event <= 100
						ORDER BY days_to_event ASC
					)UNION(
						SELECT
							cc.name,
							DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(cc.birthday, '%Y') + IF(DATE_FORMAT(cc.birthday, '%m%d') < DATE_FORMAT(NOW(), '%m%d'), 1, 0) AS new_age,
							DATEDIFF(cc.birthday + INTERVAL YEAR(NOW()) - YEAR(cc.birthday) + IF(DATE_FORMAT(NOW(), '%m%d') > DATE_FORMAT(cc.birthday, '%m%d'), 1, 0) YEAR, NOW()) AS days_to_event,
							'b' AS event_type,
							cc.birthday as event_date,
							cm1.contact_id AS contact
						FROM contacts_children AS cc
						LEFT JOIN contacts_main AS cm1
							ON cc.parent_1_id = cm1.contact_id
						LEFT JOIN contacts_main AS cm2
							ON cc.parent_1_id = cm2.contact_id
						WHERE (cm1.private = 0 OR cm2.private = 0 OR cm1.created_by = ".$this->mylogin->user()->id()." OR cm2.created_by = ".$this->mylogin->user()->id().") AND (cm1.family_id = ".$this->mylogin->user()->family_id." OR cm2.family_id = ".$this->mylogin->user()->family_id.") AND (cm1.deleted = 0 OR cm2.deleted = 0)
						HAVING days_to_event <= 100
						ORDER BY days_to_event ASC
					)UNION(
						SELECT
							CONCAT(first_name,' ',last_name) as name,
							DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(aniversary, '%Y') + IF(DATE_FORMAT(aniversary, '%m%d') < DATE_FORMAT(NOW(), '%m%d'), 1, 0) AS new_age,
							DATEDIFF(aniversary + INTERVAL YEAR(NOW()) - YEAR(aniversary) +	IF(DATE_FORMAT(NOW(), '%m%d') > DATE_FORMAT(aniversary, '%m%d'), 1, 0) YEAR, NOW()) AS days_to_event,
							'a' AS event_type,
							aniversary as event_date,
							contact_id AS contact
						FROM contacts_main
						WHERE (private = 0 OR created_by = ".$this->mylogin->user()->id().") AND family_id = ".$this->mylogin->user()->family_id." AND deleted = 0
						HAVING days_to_event <= 100
						ORDER BY days_to_event ASC
					)
				)AS data_set
				ORDER BY days_to_event
				LIMIT 10"
		)));
		
		//calendar events
		$this->mysmarty->assign('events',$this->load->activeModelReturn('model_calendar_events',array(NULL,'
			where family_id = '.$this->mylogin->user()->family_id.' and (private = 0 OR created_by = '.$this->mylogin->user()->id().') and start_date >= NOW() order by start_date ASC LIMIT 10
		')));
	}
}

?>
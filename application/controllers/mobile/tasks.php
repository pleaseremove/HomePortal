<?php

class tasks extends MyM_Controller {
	
	public function __construct(){
		parent::__construct();
		$this->mysmarty->assign('section','tasks');
	}

	function index(){
		$this->mysmarty->assign('tasks',$this->load->activeModelReturn('model_tasks',array(NULL,
			'WHERE completed = 0 AND family_id = family_id = '.$this->mylogin->user()->family_id.' AND deleted = 0 AND (private = 0 OR user_created = '.$this->mylogin->user()->id().') ORDER BY name ASC LIMIT 1000'
		)));
		
		$this->mysmarty->assign('page_title','Tasks');
		$this->mysmarty->view('mobile/tasks/index');
	}
	
	function view($taskId=0){
		$this->mysmarty->assign('task',$this->load->activeModelReturn('model_tasks',array($taskId)));
		$this->mysmarty->assign('page_title','Task: Edit');
		$this->mysmarty->view('mobile/tasks/view');
	}
}

?>
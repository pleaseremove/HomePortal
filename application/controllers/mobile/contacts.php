<?php

class contacts extends MyM_Controller {
	
	public function __construct(){
		parent::__construct();
		$this->mysmarty->assign('section','contacts');
	}

	function index(){
		$this->mysmarty->assign('contacts',$this->load->activeModelReturn('model_contacts_main',array(NULL,
			'WHERE family_id = family_id = '.$this->mylogin->user()->family_id.' AND deleted = 0 AND (private = 0 OR created_by = '.$this->mylogin->user()->id().') ORDER BY first_name, last_name DESC LIMIT 1000'
		)));
		
		$this->mysmarty->assign('page_title','Contacts');
		$this->mysmarty->view('mobile/contacts/index');
	}
	
	function view($contactId=0){
		$this->mysmarty->assign('contact',$this->load->activeModelReturn('model_contacts_main',array($contactId)));
		$this->mysmarty->assign('page_title','Contacts: View');
		$this->mysmarty->view('mobile/contacts/view');
	}
}

?>
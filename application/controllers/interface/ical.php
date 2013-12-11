<?php

class Ical extends CI_Controller {
	//This can't extented my controller because it is not expected to be accessed through a web browser

	function Ical(){
		parent::__construct();
		
	}
	
	function index(){
		$this->auth();
		
		//fetch their calendar events
		$this->mysmarty->assign('events',$this->load->activeModelReturn('model_calendar_events',array(NULL,'
			WHERE (private = 0 OR created_by = '.$this->mylogin->user()->id().')
		  AND family_id = '.$this->mylogin->user()->family_id)));
		  
		header('Content-type: text/calendar; charset=utf-8');
		header('Content-Disposition: attachment; filename=homeportal-'.$this->mylogin->user()->id().'.ical');
		
		$this->mysmarty->view('interface/ical');
	}
	
	function auth(){
		if (!isset($_SERVER['PHP_AUTH_USER'])) {
    	header('WWW-Authenticate: Basic realm="My Realm"');
    	header('HTTP/1.0 401 Unauthorized');
    	echo 'Failed to Authenticate';
    	exit;
		}else{
			if(!$this->mylogin->login($_SERVER['PHP_AUTH_USER'],$_SERVER['PHP_AUTH_PW'])){
				//failed to log in
		    header('WWW-Authenticate: Basic realm="My Realm"');
	    	header('HTTP/1.0 401 Unauthorized');
	    	echo 'Failed to Authenticate';
	    	exit;
	    }
		}
	}
		
}

?>
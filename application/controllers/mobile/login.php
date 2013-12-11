<?php

class Login extends CI_Controller {
	//This can't extented my controller becuase of the user logout logic

	function Login(){
		parent::__construct();
		
		$this->mysmarty->reset_wrapper();
		
		if ($this->mylogin->checkLoggedin() && $this->uri->segment(2) != 'logout'){
			//Already Logged In
			redirect($this->site->settings->mobile_home);
		}
	}
	
	function checklogin(){
		if($this->mylogin->login($this->input->post('username'),$this->input->post('password'))){
			redirect($this->site->settings->mobile_home);
			exit();
		}else{
			$this->index('Invalid username or password');
		}
	}
	
	function index($error=""){
		$this->mysmarty->assign('error',$error);
		$this->mysmarty->view('mobile/login');
	}
	
	function logout(){
		$this->mylogin->logout();
		redirect('/mobile/login');
	}
		
}

?>
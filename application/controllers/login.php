<?php

class Login extends CI_Controller {
	//This can't extented my controller becuase of the user logout logic

	function Login(){
		parent::__construct();
		
		if ($this->mylogin->checkLoggedin() && $this->uri->segment(2) != 'logout'){
			//Already Logged In
			redirect($this->site->settings->home);
		}
		$this->mysmarty->assign('pageheading',$this->site->display->title.' Login');
	}
	
	function checklogin(){
		if($this->mylogin->login($this->input->post('username'),$this->input->post('password'))){
			$this->session->set_userdata('public_space',$this->input->post('public_place',0));
			redirect($this->site->settings->home);
			exit();
		}else{
			$this->index('Invalid username or password');
		}
	}
	
	function requestpassword(){
		if($this->mylogin->resetpassword($this->input->post('email'))){
			$this->index('Your new password has been emailed');	
		}else{
			$this->forgotpassword('Your email address is not registered on our system, or we encounted an unexpected error');
		}
	}
	
	function index($error=""){
		$this->mysmarty->assign('error',$error);
		$this->mysmarty->view('login');
	}
	
	function forgotpassword($error=""){
		$this->mysmarty->assign('error',$error);
		$this->mysmarty->view('forgotpassword');
	}
	
	function logout(){
		$this->mylogin->logout();
		redirect('/login');
	}
		
}

?>
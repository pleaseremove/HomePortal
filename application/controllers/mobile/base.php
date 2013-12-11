<?php

class base extends MyM_Controller {

	function index(){
		$this->mysmarty->assign('page_title','Home');
		$this->mysmarty->view('mobile/base');
	}
}

?>
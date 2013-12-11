<?php

class Imports extends My_Controller {

	function index(){
		$this->json->setData($this->mysmarty->view('imports/index.tpl',false,true));
		$this->json->outputData();
	}
	
	function banking_import(){
		
		
	}

	private function fetch_options($path=''){
		return array('Option 1', 'Option 2');
	}
}

?>
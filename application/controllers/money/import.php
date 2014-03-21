<?php

class Import extends My_Controller {
	
	var $types = array();
	var $in_csv_not_hp = array();
	var $found_rows = array();
	var $too_many = array();
	var $day_slip = 4;
	var $account_id = 1;

	function ofx(){
		
		if(isset($_FILES['import_file']['tmp_name'])){
			
			$this->load->library('OFXReader',array(),'ofx');
			
			$this->ofx->load($_FILES['import_file']['tmp_name']);
			
			
			
		}
		
		$this->json->setData('<pre>'.print_r($this->ofx->get_transactions(),true).'</pre>');
		$this->json->outputData();
	}
	
}
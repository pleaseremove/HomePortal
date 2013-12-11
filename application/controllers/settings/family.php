<?php

class Family extends My_Controller {
	
	function view(){
		$this->mysmarty->assign('family',$this->load->activeModelReturn('model_families',array($this->mylogin->user()->family_id)));
		$this->json->setData($this->mysmarty->view('settings/family/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_families','fam',array($this->mylogin->user()->family_id));
		$this->fam->name = $this->input->post('name','');
		$this->fam->subdomain = $this->input->post('subdomain','');
		
		if($this->fam->save()){
			$this->json->setData(true);
			$this->json->setMessage('Details Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
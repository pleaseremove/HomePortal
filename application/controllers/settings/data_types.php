<?php

class data_types extends My_Controller {

	function all(){
		$this->mysmarty->assign('types',$this->load->activeModelReturn('model_contacts_data_types',array(NULL,
			'WHERE family_id IN(0,'.$this->mylogin->user()->family_id.')'.$this->order_by('data_type_name ASC').$this->limit_by()
		)));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Name','sort'=>'data_type_name'),
			array('label'=>'Pattern','sort'=>'data_type_view_string'),
			array('label'=>'Private','sort'=>'family_id')
		));
		
		$this->mysmarty->assign('section_title','Contact Data Types: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="settings/data_types/add" class="model inline_button" data-height="150" data-width="600" class="model inline_button">Add Data Type</a>'
		));
		
		$this->mysmarty->assign('inner_loop','settings/data_types/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('types',$this->load->activeModelReturn('model_contacts_data_types',array(NULL,
			'WHERE family_id IN(0,'.$this->mylogin->user()->family_id.')'.$this->order_by('data_type_name ASC').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('settings/data_types/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('type',$this->load->activeModelReturn('model_contacts_data_types',array($id)));
			$this->json->setData($this->mysmarty->view('settings/data_types/view',false,true));
		}else{
			$this->json->setMessage('Unknown Data Type');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('type',$this->load->activeModelReturn('model_contacts_data_types',array(0)));
		$this->json->setData($this->mysmarty->view('settings/data_types/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_contacts_data_types','datatype',array($this->input->post('type_id',0)));
		$this->datatype->data_type_name = $this->input->post('data_type_name','');
		$this->datatype->data_type_view_string = $this->input->post('data_type_view_string','<%data%>');
		$this->datatype->family_id = $this->mylogin->user()->family_id;
		
		if($this->datatype->save()){
			$this->json->setData(true);
			$this->json->setMessage('Data Type Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
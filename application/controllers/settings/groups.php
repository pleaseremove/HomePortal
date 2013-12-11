<?php

class Groups extends My_Controller {

	function all(){
		$this->mysmarty->assign('groups',$this->load->activeModelReturn('model_contacts_categories',array(NULL,
			$this->filters(true).$this->order_by('description ASC').$this->limit_by()
		)));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Description','sort'=>'description')
		));
		
		$this->mysmarty->assign('section_title','Contact Groups: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="settings/groups/add" class="model inline_button" data-height="150" data-width="400" class="model inline_button">Add Group</a>'
		));
		
		$this->mysmarty->assign('inner_loop','settings/groups/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('groups',$this->load->activeModelReturn('model_contacts_categories',array(NULL,
			$this->filters(true).$this->order_by('description ASC').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('settings/groups/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('group',$this->load->activeModelReturn('model_contacts_categories',array($id)));
			$this->json->setData($this->mysmarty->view('settings/groups/view',false,true));
		}else{
			$this->json->setMessage('Unknown Group');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('group',$this->load->activeModelReturn('model_contacts_categories',array(0)));
		$this->json->setData($this->mysmarty->view('settings/groups/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_contacts_categories','group',array($this->input->post('group_id',0)));
		$this->group->description = $this->input->post('description','');
		
		if($this->group->isNew()){
			$this->group->family_id = $this->mylogin->user()->family_id;
			$this->group->deleted = 0;
		}
		
		if($this->group->save()){
			$this->json->setData(true);
			$this->json->setMessage('Group Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
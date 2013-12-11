<?php

class Notes extends My_Controller {

	function all(){
		$this->mysmarty->assign('notes',$this->load->activeModelReturn('model_notes',array(NULL,
			$this->filters(true).' AND (private = 0 OR user_created = '.$this->mylogin->user()->id().')'.$this->order_by('name ASC').$this->limit_by()
		)));
		
		$users = $this->load->activeModelReturn('model_users',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY name ASC'));
		$users_array[''] = 'All';
		foreach($users as $user){
			$users_array[$user->id()] = $user->name;
		}
		
		$this->mysmarty->assign('filters',array(
			array(
				'label' => 'Private','name' => 'private','type' => 'select','options' => array(
					'' => 'All',
					'1' => 'Private',)
			),
			array(
				'label' => 'Created By','name' => 'user_created','type' => 'select','options' => $users_array
			)
		));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Note','sort'=>'name'),
			array('label'=>'Date Created','sort'=>'date_created'),
			array('label'=>'Date Updated','sort'=>'date_updated'),
			array('label'=>'Created By','sort'=>'user_created'),
			array('label'=>'Updated By','sort'=>'user_updated'),
			array('label'=>'Private','sort'=>'private')
		));
		
		$this->mysmarty->assign('section_title','Notes: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="notes/add" class="model inline_button" data-menu-click="notes" data-selection="notes-add" class="model inline_button">Add Note</a>'
		));
		
		$this->mysmarty->assign('inner_loop','notes/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('notes',$this->load->activeModelReturn('model_notes',array(NULL,
			$this->filters(true).' AND (private = 0 OR user_created = '.$this->mylogin->user()->id().')'.$this->order_by('name ASC').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('notes/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('note',$this->load->activeModelReturn('model_notes',array($id)));
			$this->json->setData($this->mysmarty->view('notes/view',false,true));
		}else{
			$this->json->setMessage('Unknown Note');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('note',$this->load->activeModelReturn('model_notes',array(0)));
		$this->json->setData($this->mysmarty->view('notes/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_notes','note',array($this->input->post('note_id',0)));
		$this->note->name = $this->input->post('name','');
		$this->note->note = $this->input->post('note',NULL);
		$this->note->user_updated = $this->mylogin->user()->id();
		$this->note->date_updated = date('Y-m-d H:i:s');
		$this->note->private = $this->input->post('private',0);
		
		if($this->note->isNew()){
			$this->note->family_id = $this->mylogin->user()->family_id;
			$this->note->user_created = $this->mylogin->user()->id();
			$this->note->date_created = date('Y-m-d H:i:s');
			$this->note->deleted = 0;
		}
		
		if($this->note->save()){
			$this->json->setData(true);
			$this->json->setMessage('Note Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
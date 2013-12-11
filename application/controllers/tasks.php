<?php

class Tasks extends My_Controller {

	function all(){
		$this->mysmarty->assign('tasks',$this->load->activeModelReturn('model_tasks',array(NULL,
			$this->filters(true,false,array('filter'=>array('completed'=>'0'))).' AND (private = 0 OR user_created = '.$this->mylogin->user()->id().')'.$this->order_by('name ASC').$this->limit_by()
		)));
		
		$users = $this->load->activeModelReturn('model_users',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY name ASC'));
		$users_array[''] = 'All';
		foreach($users as $user){
			$users_array[$user->id()] = $user->name;
		}
		
		$this->mysmarty->assign('filters',array(
			array(
				'label' => 'Show','name' => 'completed','type' => 'select','default' => '0','options' => array(
					'' => 'All',
					'1' => 'Completed',
					'0' => 'In-Complete')
			),
			array(
				'label' => 'Private','name' => 'private','type' => 'select','options' => array(
					'' => 'All',
					'1' => 'Private',)
			),
			array(
				'label' => 'Created By','name' => 'user_created','type' => 'select','options' => $users_array
			),
			array(
				'label' => 'Priority','name' => 'priority','type' => 'select','options' => array(
					'' => 'All',
					'1' => 'Very Low',
					'2' => 'Low',
					'3' => 'Normal',
					'4' => 'High',
					'5' => 'Very High')
			)
		));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Task','sort'=>'name'),
			array('label'=>'Date Created','sort'=>'date_created'),
			array('label'=>'Date Due','sort'=>'date_due'),
			array('label'=>'Priority','sort'=>'priority'),
			array('label'=>'Added By','sort'=>'user_created'),
			array('label'=>'Complete','sort'=>'completed')
		));
		
		$this->mysmarty->assign('section_title','Tasks: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="tasks/add" class="model inline_button" data-menu-click="tasks" data-selection="tasks-add" class="model inline_button">Add Task</a>'
		));
		
		$this->mysmarty->assign('inner_loop','tasks/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('tasks',$this->load->activeModelReturn('model_tasks',array(NULL,
			$this->filters(true).' AND (private = 0 OR user_created = '.$this->mylogin->user()->id().')'.$this->order_by('name ASC').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('tasks/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('task',$this->load->activeModelReturn('model_tasks',array($id)));
			$this->json->setData($this->mysmarty->view('tasks/view',false,true));
		}else{
			$this->json->setMessage('Unknown Task');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('task',$this->load->activeModelReturn('model_tasks',array(0)));
		$this->json->setData($this->mysmarty->view('tasks/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_tasks','task',array($this->input->post('task_id',0)));
		$this->task->name = $this->input->post('name','');
		$this->task->details = $this->input->post('description',NULL);
		$this->task->date_due = $this->input->post('date_due',NULL);
		$this->task->priority = $this->input->post('priority',3);
		$this->task->completed = $this->input->post('completed',0);
		$this->task->private = $this->input->post('private',0);
		
		if($this->task->isNew()){
			$this->task->family_id = $this->mylogin->user()->family_id;
			$this->task->user_created = $this->mylogin->user()->id();
			$this->task->date_created = date('Y-m-d H:i:s');
			$this->task->deleted = 0;
		}
		
		if($this->task->save()){
			$this->json->setData(true);
			$this->json->setMessage('Task Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
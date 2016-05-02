<?php

class Users extends My_Controller {

	function all(){
		$this->mysmarty->assign('users',$this->load->activeModelReturn('model_users',array(NULL,
			$this->filters(true).$this->order_by('name ASC').$this->limit_by()
		)));
		
		/*$this->mysmarty->assign('filters',array(
			array(
				'label' => 'Level','name' => 'is_admin','type' => 'select','options' => array(
					'' => 'All',
					'1' => 'Admin',
					'0' => 'Non Admin')
			)
		));*/
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Name','sort'=>'name'),
			array('label'=>'Username','sort'=>'username'),
			array('label'=>'Last Login','sort'=>'last_logged_in'),
			array('label'=>'Admin','sort'=>'is_admin')
		));
		
		$this->mysmarty->assign('section_title','Users: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="settings/users/add" class="model inline_button" data-selection="users-add" class="model inline_button">Add User</a>'
		));
		
		$this->mysmarty->assign('inner_loop','settings/users/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('users',$this->load->activeModelReturn('model_users',array(NULL,
			$this->filters(true).$this->order_by('name ASC').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('settings/users/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('user',$this->load->activeModelReturn('model_users',array($id)));
			$this->json->setData($this->mysmarty->view('settings/users/view',false,true));
		}else{
			$this->json->setMessage('Unknown User');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('user',$this->load->activeModelReturn('model_users',array(0)));
		$this->json->setData($this->mysmarty->view('settings/users/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_users','user',array($this->input->post('user_id',0)));
		$this->user->name = $this->input->post('name','');
		$this->user->username = $this->input->post('username',NULL);
		$this->user->reminder_days = $this->input->post('reminder_days',10);
		$this->user->email = $this->input->post('email',NULL);
		$this->user->email_alerts = $this->input->post('email_alerts',0);
		
		if($this->mylogin->user()->is_admin()){
			$this->user->is_admin = $this->input->post('is_admin',0);
		}else{
			$this->user->is_admin = 0;
		}
		
		if($this->user->isNew()){
			$this->user->family_id = $this->mylogin->user()->family_id;
			$this->user->created_date = date('Y-m-d H:i:s');
			$this->user->deleted = 0;

			//check we have the new password details
			if(!$this->input->post('new_password1','') && !$this->input->post('new_password2','')){
				
				//check they are the same
				if($this->input->post('new_password1','') == $this->input->post('new_password2','')){
					
					//create the password and the hash details
					$this->user->pass_salt = md5(uniqid(time(),true));
					$this->user->password = $this->input->post('new_password1','');

				}else{
					$this->json->setData(false);
					$this->json->setMessage('Passwords do not match');
					$this->json->outputData();
				}
			}else{
				$this->json->setData(false);
				$this->json->setMessage('Must enter a password');
				$this->json->outputData();
			}
			
		}else{
			
			//check they are editing the current user or they are admin
			if($this->mylogin->user()->is_admin() || $this->mylogin->user()->id() == $this->user->id()){
				
				//if they are not admin check their old password is right
				if(!$this->mylogin->user()->is_admin() || $this->mylogin->user()->id() == $this->user->id()){
					if(!$this->mylogin->check_password($this->input->post('old_password',''))){
						$this->json->setData(false);
						$this->json->setMessage('Old password was not correct');
						$this->json->outputData();
					}
				}
			
				//check they are the same
				if($this->input->post('new_password1','') == $this->input->post('new_password2','')){
					
					//create the password and the hash details
					$this->user->pass_salt = md5(uniqid(time(),true));
					$this->user->password = $this->input->post('new_password1','');

				}else{
					$this->json->setData(false);
					$this->json->setMessage('Passwords do not match');
					$this->json->outputData();
				}
			}
			
		}
		
		if($this->user->save()){
			$this->json->setData(true);
			$this->json->setMessage('User Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
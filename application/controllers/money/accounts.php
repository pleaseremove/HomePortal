<?php

class Accounts extends My_Controller {

	function index(){
		$this->mysmarty->assign('accounts',$this->load->activeModelReturn('model_money_accounts',array(NULL,$this->filters(true).$this->order_by('name').$this->limit_by())));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Name','sort'=>'name'),
			array('label'=>'Description','sort'=>'description'),
			array('label'=>'Type','sort'=>'type')
		));
		
		$this->mysmarty->assign('section_title','Money Accounts: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="money/accounts/add" class="model inline_button" data-height="200" data-menu-click="money-accounts" data-selection="money-accounts" class="model inline_button">Add Account</a>'
		));
		
		$this->mysmarty->assign('inner_loop','money/accounts/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('accounts',$this->load->activeModelReturn('model_money_accounts',array(NULL,$this->filters(true).$this->order_by('name').$this->limit_by())));
		
		$this->json->setData($this->mysmarty->view('money/accounts/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('account',$this->load->activeModelReturn('model_money_accounts',array($id)));
			$this->json->setData($this->mysmarty->view('money/accounts/view',false,true));
		}else{
			$this->json->setMessage('Unknown Account');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('account',$this->load->activeModelReturn('model_money_accounts',array(0)));
		$this->json->setData($this->mysmarty->view('money/accounts/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_money_accounts','account',array($this->input->post('account_id',0)));
		$this->account->name = $this->input->post('name','');
		$this->account->description = $this->input->post('description',NULL);
		$this->account->verified = $this->input->post('verified',0);
		$this->account->type = $this->input->post('type','');
		$this->account->hide = $this->input->post('hide',0);
		
		if($this->account->isNew()){
			$this->account->family_id = $this->mylogin->user()->family_id;
			$this->account->deleted = 0;
			$this->account->default = 0;
		}
		
		if($this->account->save()){
			$this->json->setData(true);
			$this->json->setMessage('Account Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
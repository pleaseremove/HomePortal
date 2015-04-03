<?php

class Transfers extends My_Controller {

	function all(){
		$this->mysmarty->assign('transfers',$this->load->activeModelReturn('model_money_transfers',array(NULL,
			$this->filters(true).$this->order_by('date DESC').$this->limit_by()
		)));
		
		$accounts = $this->load->activeModelReturn('model_money_accounts',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY name ASC'));
		$account_array[''] = 'All';
		foreach($accounts as $account){
			$account_array[$account->name] = $account->name;
		}
		
		$this->mysmarty->assign('filters',array(
			array(
				'type' => 'data_range','start_name' => 'date','end_name' => 'date'
			),
			array(
				'label' => 'Account From','name' => 'out_account','type' => 'select','options' => $account_array
			),
			array(
				'label' => 'Account To','name' => 'in_account','type' => 'select','options' => $account_array
			),
		));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Date','sort'=>'date'),
			array('label'=>'Account From','sort'=>'out_account'),
			array('label'=>'Account To','sort'=>'in_account'),
			array('label'=>'Amount','sort'=>'amount'),
		));
		
		$this->mysmarty->assign('section_title','Money Transfers: All');
		
		$this->mysmarty->assign('title_buttons',array('<a data-selection="money-transfer" data-height="300" data-menu-click="money-transfers" href="money/transfers/add" class="model inline_button">New Transfer</a>'));
		
		$this->mysmarty->assign('inner_loop','money/transfers/all');
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('transfers',$this->load->activeModelReturn('model_money_transfers',array(NULL,
			$this->filters(true).$this->order_by('date DESC').$this->limit_by()
		)));
			
		$this->json->setData($this->mysmarty->view('money/transfers/all',false,true));
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('accounts',$this->load->activeModelReturn('model_money_accounts',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' AND hide = 0 ORDER BY name ASC')));
		$this->json->setData($this->mysmarty->view('money/transfers/add',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$tran_in_save = false;
		$tran_out_save = false;
		
		$cat_in = $this->db->query('SELECT money_category_id FROM money_catagories WHERE system = "trans_in" LIMIT 1')->row_array();
		$cat_out = $this->db->query('SELECT money_category_id FROM money_catagories WHERE system = "trans_out" LIMIT 1')->row_array();
		
		$item_in = $this->load->activeModelReturn('model_money_items',array(0));
		$item_in->family_id = $this->mylogin->user()->family_id;
		$item_in->account_id = $this->input->post('account_id_to',0);
		$item_in->trans_type = 1;
		$item_in->description = mysql_real_escape_string($this->input->post('description'));
		$item_in->date = $this->input->post('date',date('Y-m-d'));
		$item_in->deleted = 0;
		$item_in->added_by = $this->mylogin->user()->id();
		$item_in->added_datetime = date('Y-m-d H:i:s');
		$item_in->confirmed = 0;
		$item_in->bank_date = NULL;
		if($item_in->save()){
			$tran_in = $this->load->activeModelReturn('model_money_transactions',array(0));
			$tran_in->item_id = $item_in->id();
			$tran_in->category_id = $cat_in['money_category_id'];
			$tran_in->amount = $this->input->post('amount',0);
			$tran_in_save = $tran_in->save();
		}
		
		$item_out = $this->load->activeModelReturn('model_money_items',array(0));
		$item_out->family_id = $this->mylogin->user()->family_id;
		$item_out->account_id = $this->input->post('account_id_from',0);
		$item_out->trans_type = -1;
		$item_out->description = mysql_real_escape_string($this->input->post('description'));
		$item_out->date = $this->input->post('date',date('Y-m-d'));
		$item_out->deleted = 0;
		$item_out->added_by = $this->mylogin->user()->id();
		$item_out->added_datetime = date('Y-m-d H:i:s');
		$item_out->confirmed = 0;
		$item_out->bank_date = NULL;
		if($item_out->save()){
			$tran_out = $this->load->activeModelReturn('model_money_transactions',array(0));
			$tran_out->item_id = $item_out->id();
			$tran_out->category_id = $cat_out['money_category_id'];
			$tran_out->amount = $this->input->post('amount',0);
			$tran_out_save = $tran_out->save();
		}
		
		if($tran_in_save==true && $tran_out_save==true){
			$this->json->setData(true);
			$this->json->setMessage('Transfer Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Transfer failed to save');
		}

		$this->json->outputData();
	}
	
}

?>
<?php

class money extends MyM_Controller {

	public function __construct(){
		parent::__construct();
		$this->mysmarty->assign('section','money');
	}

	function index(){
		$this->mysmarty->assign('page_title','Money');
		$this->mysmarty->view('mobile/money/index');
	}

	function all(){
		$this->mysmarty->assign('page_title','Money: All');
		$this->mysmarty->assign('accounts',$this->load->activeModelReturn('model_money_accounts',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY name ASC')));
		$this->mysmarty->assign('categories',$this->load->activeModelReturn('model_money_catagories',array(NULL,NULL,'SELECT jc.description as description, jc.money_category_id as id, c.description as parent FROM money_catagories AS c RIGHT JOIN money_catagories AS jc ON c.money_category_id = jc.parent WHERE jc.parent <> 0 AND c.family_id = '.$this->mylogin->user()->family_id.' ORDER BY c.description, jc.description')));

		$this->mysmarty->assign('transactions',$this->load->activeModelReturn('model_money_transactions',array(NULL,NULL,'SELECT v_money_transactions.* FROM v_money_transactions JOIN money_transactions ON v_money_transactions.item_id = money_transactions.item_id '.
			$this->filters(true).' GROUP BY v_money_transactions.item_id '.$this->order_by('date DESC, item_id DESC').$this->limit_by(0,200)
		)));
		$this->mysmarty->view('mobile/money/transactions');
	}

	function edit($id=0){
		$this->mysmarty->assign('accounts',$this->load->activeModelReturn('model_money_accounts',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.($id==0 ? ' AND hide = 0 ':'').' ORDER BY name ASC')));
		$this->mysmarty->assign('categories',$this->load->activeModelReturn('model_money_catagories',array(NULL,NULL,'SELECT jc.description as description, jc.money_category_id as id, c.description as parent FROM money_catagories AS c RIGHT JOIN money_catagories AS jc ON c.money_category_id = jc.parent WHERE jc.parent <> 0 AND c.family_id = '.$this->mylogin->user()->family_id.' ORDER BY c.description, jc.description')));
		$this->mysmarty->assign('t',$this->load->activeModelReturn('model_money_items',array($id)));
		$this->mysmarty->view('mobile/money/view');
	}

	function save(){
		if(isset($_POST['account_id']) && !empty($_POST['account_id'])){
			$this->load->activeModel('model_money_items','trans_item',array($this->input->post('item_id',0)));
			$this->trans_item->family_id = $this->mylogin->user()->family_id;
			$this->trans_item->account_id = $this->input->post('account_id',0);
			$this->trans_item->trans_type = $this->input->post('trans_type',-1);
			$this->trans_item->description = mysql_real_escape_string($this->input->post('description'));
			$this->trans_item->date = $this->input->post('date',date('Y-m-d'));
			$this->trans_item->deleted = 0;
			$this->trans_item->added_by = $this->mylogin->user()->id();
			$this->trans_item->added_datetime = date('Y-m-d H:i:s');
			$this->trans_item->confirmed = 0;
			$this->trans_item->bank_date = NULL;

			if($this->trans_item->save()){

				foreach($this->input->post('catagory_id',array()) as $k => $cat_id){
					$tran = $this->load->activeModelReturn('model_money_transactions',array(0));
					$tran->item_id = $this->trans_item->id();
					$tran->category_id = $cat_id;
					$tran->amount = (isset($_POST['amount'][$k]) && !empty($_POST['amount'][$k]) ? $_POST['amount'][$k] : 0 );
					$tran->save();
				}
			}
		}

		$this->mysmarty->assign('page_title','Money');
		$this->mysmarty->view('mobile/money/index');
	}

	function transfer(){
		$this->mysmarty->assign('accounts',$this->load->activeModelReturn('model_money_accounts',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY name ASC')));
		$this->mysmarty->view('mobile/money/transfer');
	}

	function save_transfer(){
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
			$this->mysmarty->assign('page_title','Money');
			$this->mysmarty->view('mobile/money/index');
		}else{
			echo 'Failed';
		}
	}
}

?>

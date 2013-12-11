<?php

class Categories extends My_Controller {
	
	var $view_sql = 'select 
		mc.family_id AS family_id,
		mc.money_category_id AS money_category_id,
		mc2.description AS parent_desc,
		mc.description AS cat_desc,
		mc.parent AS parent,
		sum(if((mi.trans_type = 1),1,0)) AS trans_count_in,
		sum(if((mi.trans_type = -(1)),1,0)) AS trans_count_out,
		round(sum(if((mi.trans_type = 1),mt.amount,0)),2) AS total_in,
		round(sum(if((mi.trans_type = -(1)),mt.amount,0)),2) AS total_out,
		round(avg(if((mi.trans_type = 1),mt.amount,0)),2) AS average_in,
		round(avg(if((mi.trans_type = -(1)),mt.amount,0)),2) AS average_out,
		0 AS deleted
	FROM money_catagories AS mc
	JOIN money_catagories AS mc2
		ON mc.parent = mc2.money_category_id
	LEFT JOIN money_transactions AS mt
		ON mc.money_category_id = mt.category_id
	LEFT JOIN money_items AS mi
		ON mt.item_id = mi.item_id ';

	function index(){
		$this->mysmarty->assign('categories',$this->load->activeModelReturn('model_money_catagories',array(NULL,NULL,
			$this->view_sql.$this->filters(true,'mi').' GROUP BY mc.money_category_id '.$this->order_by('parent_desc, cat_desc').$this->limit_by()
		)));
		
		$accounts = $this->load->activeModelReturn('model_money_accounts',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY name ASC'));
		$account_array[''] = 'All';
		foreach($accounts as $account){
			$account_array[$account->id()] = $account->name;
		}
		
		$this->mysmarty->assign('filters',array(
			array(
				'type' => 'data_range','start_name' => 'date','end_name' => 'date'
			),
			array(
				'label' => 'Account','name' => 'account_id','type' => 'select','options' => $account_array
			)
		));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Parent','sort'=>'parent_desc'),
			array('label'=>'Category','sort'=>'cat_desc'),
			array('label'=>'Total In','sort'=>'total_in'),
			array('label'=>'Total Out','sort'=>'total_out'),
			array('label'=>'Count In','sort'=>'trans_count_in'),
			array('label'=>'Count Out','sort'=>'trans_count_out'),
			array('label'=>'Detailed Stats')
		));
		
		$this->mysmarty->assign('section_title','Money Categories: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="money/categories/add" class="model inline_button" data-height="260" data-width="500" data-menu-click="money-categories" data-selection="money-categories" class="model inline_button">Add Category</a>'
		));
		
		$this->mysmarty->assign('inner_loop','money/categories/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('categories',$this->load->activeModelReturn('model_money_catagories',array(NULL,NULL,
			$this->view_sql.$this->filters(true,'mi').' GROUP BY mc.money_category_id '.$this->order_by('parent_desc, cat_desc').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('money/categories/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('categories',$this->load->activeModelReturn('model_money_catagories',array(NULL,'WHERE parent = 0 AND family_id = '.$this->mylogin->user()->family_id.' ORDER BY description')));
			$this->mysmarty->assign('category',$this->load->activeModelReturn('model_money_catagories',array($id)));
			$this->json->setData($this->mysmarty->view('money/categories/view',false,true));
		}else{
			$this->json->setMessage('Unknown Category');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('categories',$this->load->activeModelReturn('model_money_catagories',array(NULL,'WHERE parent = 0 AND family_id = '.$this->mylogin->user()->family_id.' ORDER BY description')));
		$this->mysmarty->assign('category',$this->load->activeModelReturn('model_money_catagories',array(0)));
		$this->json->setData($this->mysmarty->view('money/categories/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		
		$this->load->activeModel('model_money_catagories','category',array($this->input->post('category_id',0)));
		
		$this->category->description = $this->input->post('description','');
		$this->category->parent = $this->input->post('parent',0);
		$this->category->dont_include_in_stats = $this->input->post('dont_include_in_stats',0);
		
		if($this->input->post('new_parent','') !=''){
			$this->load->activeModel('model_money_catagories','new_category',array(0));
			$this->new_category->description = $this->input->post('new_parent','');
			$this->new_category->family_id = $this->mylogin->user()->family_id;
			$this->new_category->color = $this->input->post('new_parent_color',NULL);
			$this->new_category->parent = 0;
			$this->new_category->dont_include_in_stats = 0;
			$this->new_category->top_level = 1;
			$this->new_category->save();
			$this->category->parent = $this->new_category->id();
		}
		
		if($this->category->isNew()){
			$this->category->family_id = $this->mylogin->user()->family_id;
			$this->category->top_level = 0;
			$this->category->color = NULL;
		}
		
		if($this->category->save()){
			$this->json->setData(true);
			$this->json->setMessage('Category Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
	
	function stats($id=0){
		if($this->input->post('category',0)!=0){
			$id = $this->input->post('category',0);
		}
		
		if($id!=0){
			$this->mysmarty->assign('category',$this->load->activeModelReturn('model_money_catagories',array($id)));
			
			$this->mysmarty->assign('categories',$this->load->activeModelReturn('model_money_catagories',array(NULL,NULL,'SELECT jc.description as description, jc.money_category_id as id, c.description as parent FROM money_catagories AS c RIGHT JOIN money_catagories AS jc ON c.money_category_id = jc.parent WHERE jc.parent <> 0 AND c.family_id = '.$this->mylogin->user()->family_id.' ORDER BY c.description, jc.description')));
			
			$this->mysmarty->assign('money_stats',$this->load->activeModelReturn('model_money_transactions',array(NULL,NULL,'
			SELECT
				ROUND(SUM(mi.trans_type*mt.amount),2) as "net_gain_loss",
				ROUND(AVG(if(mi.trans_type=1,mt.amount,0)),2) as "average_in",
				ROUND(AVG(if(mi.trans_type=-1,mt.amount,0)),2) as "average_out",
				ROUND(SUM(if(mi.trans_type=1,mt.amount,0)),2) as "total_in",
				ROUND(SUM(if(mi.trans_type=-1,mt.amount,0)),2) as "total_out",
				SUM(if(mi.trans_type=1,1,0)) as "count_in",
 				SUM(if(mi.trans_type=-1,1,0)) as "count_out"
			FROM money_transactions AS mt
			JOIN money_items AS mi
				ON mt.item_id = mi.item_id
			WHERE mt.category_id = '.$id.'
				AND '.$this->filters(false,'mi'))));
			
			$this->json->setData($this->mysmarty->view('money/categories/stats',false,true));
		}else{
			$this->json->setMessage('Unknown Category');
		}
		$this->json->outputData();
	}
}

?>
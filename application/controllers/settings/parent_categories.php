<?php

class Parent_categories extends My_Controller {

	function index(){
		$this->mysmarty->assign('categories',$this->load->activeModelReturn('model_money_catagories',array(NULL,
			'WHERE parent = 0 AND '.$this->filters().$this->order_by('description').$this->limit_by()
		)));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Parent','sort'=>'description')
		));
		
		$this->mysmarty->assign('section_title','Money Categories: Parents');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="settings/parent_categories/add" class="model inline_button" data-height="260" data-width="500" data-menu-click="money-categories" data-selection="money-categories" class="model inline_button">Add Category</a>'
		));
		
		$this->mysmarty->assign('inner_loop','settings/parent_categories/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('categories',$this->load->activeModelReturn('model_money_catagories',array(NULL,
			'WHERE parent = 0 '.$this->filters(false,'mi').$this->order_by('description').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('settings/parent_categories/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('category',$this->load->activeModelReturn('model_money_catagories',array($id)));
			$this->json->setData($this->mysmarty->view('settings/parent_categories/view',false,true));
		}else{
			$this->json->setMessage('Unknown Category');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('category',$this->load->activeModelReturn('model_money_catagories',array(0)));
		$this->json->setData($this->mysmarty->view('settings/parent_categories/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		
		$this->load->activeModel('model_money_catagories','new_category',array(0));
		$this->new_category->description = $this->input->post('new_parent','');
		$this->new_category->family_id = $this->mylogin->user()->family_id;
		$this->new_category->color = $this->input->post('new_parent_color',NULL);
		$this->new_category->parent = 0;
		$this->new_category->dont_include_in_stats = 0;
		$this->new_category->top_level = 1;
		$this->new_category->save();
		
		if($this->new_category->save()){
			$this->json->setData(true);
			$this->json->setMessage('Category Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}

}

?>
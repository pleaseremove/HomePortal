<?php

class Containers extends My_Controller {

	function index(){
		$this->mysmarty->assign('containers',$this->load->activeModelReturn('model_inventory_containers',array(NULL,NULL,
			'SELECT	*	FROM v_inventory_containers '.$this->filters(true).$this->order_by('container_name ASC').$this->limit_by()
		)));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Name','sort'=>'container_name'),
			array('label'=>'Type','sort'=>'container_type'),
			array('label'=>'Location','sort'=>'location_name'),
			array('label'=>'Item Count','sort'=>'item_count')
		));
		
		$this->mysmarty->assign('section_title','Inventory Containers: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="inventory/containers/add" class="model inline_button" data-height="200" data-menu-click="inventory-containers" data-selection="inventory-containers-add" class="model inline_button">Add Container</a>'
		));
		
		$this->mysmarty->assign('inner_loop','inventory/containers/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('containers',$this->load->activeModelReturn('model_inventory_containers',array(NULL,NULL,
			'SELECT	*	FROM v_inventory_containers '.$this->filters(true).$this->order_by('container_name ASC').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('inventory/containers/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('locations',$this->load->activeModelReturn('model_inventory_locations',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY location_name')));
			$this->mysmarty->assign('container',$this->load->activeModelReturn('model_inventory_containers',array($id)));
			$this->json->setData($this->mysmarty->view('inventory/containers/view',false,true));
		}else{
			$this->json->setMessage('Unknown Container');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('locations',$this->load->activeModelReturn('model_inventory_locations',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY location_name')));
		$this->mysmarty->assign('container',$this->load->activeModelReturn('model_inventory_containers',array(0)));
		$this->json->setData($this->mysmarty->view('inventory/containers/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_inventory_containers','container',array($this->input->post('container_id',0)));
		$this->container->location_id = $this->input->post('location_id',0);
		$this->container->container_name = $this->input->post('container_name','');
		$this->container->container_type = $this->input->post('container_type',NULL);
		
		if($this->container->isNew()){
			$this->container->family_id = $this->mylogin->user()->family_id;
			$this->container->deleted = 0;
		}
		
		if($this->container->save()){
			$this->json->setData(true);
			$this->json->setMessage('Container Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
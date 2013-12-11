<?php

class Locations extends My_Controller {

	function index(){
		$this->mysmarty->assign('locations',$this->load->activeModelReturn('model_inventory_locations',array(NULL,
			$this->filters(true).$this->order_by('location_name ASC').$this->limit_by()
		)));
		
		$this->mysmarty->assign('headers',array(
			'Name','Description'
		));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Name','sort'=>'location_name'),
			array('label'=>'Description','sort'=>'location_description')
		));
		
		$this->mysmarty->assign('section_title','Inventory Locations: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="inventory/locations/add" class="model inline_button" data-height="230" data-menu-click="inventory-locations" data-selection="inventory-locations-add" class="model inline_button">Add Location</a>'
		));
		
		$this->mysmarty->assign('inner_loop','inventory/locations/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('locations',$this->load->activeModelReturn('model_inventory_locations',array(NULL,
			$this->filters(true).$this->order_by('location_name ASC').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('inventory/locations/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('location',$this->load->activeModelReturn('model_inventory_locations',array($id)));
			$this->json->setData($this->mysmarty->view('inventory/locations/view',false,true));
		}else{
			$this->json->setMessage('Unknown Location');
		}
		
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('location',$this->load->activeModelReturn('model_inventory_locations',array(0)));
			$this->json->setData($this->mysmarty->view('inventory/locations/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_inventory_locations','location',array($this->input->post('location_id',0)));
		$this->location->location_name = $this->input->post('location_name','');
		$this->location->location_description = $this->input->post('location_description',NULL);
		
		if($this->location->isNew()){
			$this->location->family_id = $this->mylogin->user()->family_id;
			$this->location->deleted = 0;
		}
		
		if($this->location->save()){
			$this->json->setData(true);
			$this->json->setMessage('Location Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
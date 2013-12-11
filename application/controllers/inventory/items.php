<?php

class Items extends My_Controller {

	function index(){
		$this->mysmarty->assign('items',$this->load->activeModelReturn('model_inventory_items',array(NULL,
			$this->filters(true).$this->order_by('name ASC').$this->limit_by()
		)));
		
		$users = $this->load->activeModelReturn('model_users',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY name ASC'));
		$users_array[''] = 'All';
		foreach($users as $user){
			$users_array[$user->id()] = $user->name;
		}
		
		$containers = $this->load->activeModelReturn('model_inventory_containers',array(NULL,' AS c JOIN inventory_locations AS l ON c.location_id = l.location_id WHERE c.family_id = '.$this->mylogin->user()->family_id.' ORDER BY location_name, container_name ASC'));
		$containers_array[''] = 'All';
		foreach($containers as $container){
			$containers_array[$container->location_name][$container->id()] = $container->container_name;
		}
		
		$this->mysmarty->assign('filters',array(
			array(
				'label' => 'Added By','name' => 'user_added','type' => 'select','options' => $users_array
			),
			array(
				'label' => 'Container','name' => 'container_id','type' => 'select','options' => $containers_array
			)
		));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'Name','sort'=>'name'),
			array('label'=>'Bought For','sort'=>'bought_for'),
			array('label'=>'Current Value','sort'=>'current_value'),
			array('label'=>'Container','sort'=>'container_id'),
			array('label'=>'Location')
		));
		
		$this->mysmarty->assign('section_title','Inventory Items: All');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="inventory/items/add" class="model inline_button" data-menu-click="inventory-items" data-selection="inventory-items-add" class="model inline_button">Add Item</a>'
		));
		
		$this->mysmarty->assign('inner_loop','inventory/items/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('items',$this->load->activeModelReturn('model_inventory_items',array(NULL,
			$this->filters(true).$this->order_by('name ASC').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('inventory/items/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('containers',$this->load->activeModelReturn('model_inventory_containers',array(NULL,NULL,'SELECT il.location_name AS location, ic.container_name AS container, ic.container_id FROM inventory_containers AS ic JOIN inventory_locations AS il ON ic.location_id = il.location_id WHERE ic.family_id = '.$this->mylogin->user()->family_id.' AND il.family_id = '.$this->mylogin->user()->family_id.' ORDER BY il.location_name')));
			$this->mysmarty->assign('item',$this->load->activeModelReturn('model_inventory_items',array($id)));
			$this->json->setData($this->mysmarty->view('inventory/items/view',false,true));
		}else{
			$this->json->setMessage('Unknown Item');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('containers',$this->load->activeModelReturn('model_inventory_containers',array(NULL,NULL,'SELECT il.location_name AS location, ic.container_name AS container, ic.container_id FROM inventory_containers AS ic JOIN inventory_locations AS il ON ic.location_id = il.location_id WHERE ic.family_id = '.$this->mylogin->user()->family_id.' AND il.family_id = '.$this->mylogin->user()->family_id.' ORDER BY il.location_name')));
		$this->mysmarty->assign('item',$this->load->activeModelReturn('model_inventory_items',array(0)));
		$this->json->setData($this->mysmarty->view('inventory/items/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_inventory_items','item',array($this->input->post('invent_id',0)));
		$this->item->container_id = $this->input->post('container_id',0);
		$this->item->name = $this->input->post('name','');
		$this->item->description = $this->input->post('description',NULL);
		$this->item->bought_for = $this->input->post('bought_for',0);
		$this->item->current_value = $this->input->post('current_value',0);
		$this->item->quantity = $this->input->post('quantity',1);
		
		if($this->item->isNew()){
			$this->item->family_id = $this->mylogin->user()->family_id;
			$this->item->user_added = $this->mylogin->user()->id();
			$this->item->datetime_added = date('Y-m-d H:i:s');
			$this->item->deleted = 0;
		}
		
		if($this->item->save()){
			$this->json->setData(true);
			$this->json->setMessage('Item Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}
		
		$this->json->outputData();
	}
}

?>
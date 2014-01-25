<?php

class Calendar extends My_Controller {

	function index(){
		$this->json->setData($this->mysmarty->view('calendar/index',false,true));
		$this->json->outputData();
	}
	
	function all(){
		$this->load->activeModel('model_calendar_events','events',array(NULL,NULL,NULL));
		$events = $this->events->get_events($this->input->get('start'),$this->input->get('end'));
		
		$return_events = array();
		
		foreach($events as $event){
			$return_events[] = array(
				'id' => $event->event_id,
				'title' => $event->title,
				'start' => $event->start_date,
				'end' => $event->end_date,
				'allDay' => ($event->all_day==1 ? true : false),
				'eventType' => $event->event_type,
				'editable' => (($event->event_type=='b' || $event->event_type=='a') ? false : true),
				'className' => $event->event_class.($event->tentative==1 ? ' event_tentative' : '')
			);
		}
		
		echo json_encode($return_events);
	}
	
	function add(){
		$this->mysmarty->assign('event',$this->load->activeModelReturn('model_calendar_events',array(0)));
		$this->json->setData($this->mysmarty->view('calendar/view',false,true));
		$this->json->outputData();
	}
	
	function save(){
		$this->load->activeModel('model_calendar_events','event',array($this->input->post('event_id',0)));
		
		if($this->input->post('delete',0)==1 && !$this->event->isNew()){
			$this->event->delete();
			$this->json->setData(true);
			$this->json->setMessage('Event Deleted');
		}else{
			$this->event->start_date = $this->input->post('start_date');
			$this->event->end_date = $this->input->post('end_date');
			$this->event->start_time = $this->input->post('start_time','00:00').':00';
			$this->event->end_time = $this->input->post('end_time','00:00').':00';
			$this->event->title = $this->input->post('title','');
			$this->event->description = $this->input->post('description','');
			$this->event->location = $this->input->post('location',NULL);
			$this->event->tentative = $this->input->post('tentative',0);
			$this->event->repeat = $this->input->post('repeat',0);
			if($this->input->post('start_time','00:00')!='00:00' || $this->input->post('end_time','00:00')!='00:00'){
				$this->event->all_day = 0;
			}else{
				$this->event->all_day = $this->input->post('all_day',0);
			}
			$this->event->private = $this->input->post('private',0);
			$this->event->important = $this->input->post('important',0);
			$this->event->updated_by = $this->mylogin->user()->id();
			$this->event->updated_datetime = date('Y-m-d H:i:s');
			
			if($this->event->isNew()){
				$this->event->family_id = $this->mylogin->user()->family_id;
				$this->event->created_by = $this->mylogin->user()->id();
				$this->event->created_datetime = date('Y-m-d H:i:s');
				$this->event->sequence = 0;
			}else{
				$this->event->sequence = $this->event->sequence+1;
			}
		
			if($this->event->save()){
				$this->json->setData(true);
				$this->json->setMessage('Event Saved');
			}else{
				$this->json->setData(false);
				$this->json->setMessage('Failed to save');
			}
		}
		
		$this->json->outputData();
	}
	
	function event($id=0){
		if($id!=0){
			$this->mysmarty->assign('event',$this->load->activeModelReturn('model_calendar_events',array($id)));
			$this->json->setData($this->mysmarty->view('calendar/view',false,true));
		}else{
			$this->json->setMessage('Unknown Event');
		}
		
		$this->json->outputData();
	}
	
	function update_time(){
		$type = substr($this->input->post('id'),0,1);
		$id = substr($this->input->post('id'),1,10);
		$start_date = date("Y-m-d", strtotime($this->input->post('start')));
		$end_date = date("Y-m-d", strtotime($this->input->post('end')));
		$start_time = date("H:i:s", strtotime($this->input->post('start')));
		$end_time = date("H:i:s", strtotime($this->input->post('end')));
		
		if($type=='t'){
			$event = $this->load->activeModelReturn('model_tasks',array($id));
			$event->date_due = $start_date.' '.$start_time;
		}elseif($type=='c'){
			$event = $this->load->activeModelReturn('model_calendar_events',array($id));
			$event->all_day = $this->input->post('all_day',1);
			$event->start_date = $start_date;
			$event->end_date = $end_date;
			$event->start_time = $start_time;
			$event->end_time = $end_time;
		}
		
		if($event->save()){
			$this->json->setData(true);
			$this->json->setMessage('Event Saved');
		}else{
			$this->json->setData(false);
		}
		
		$this->json->outputData();
	}
}

?>
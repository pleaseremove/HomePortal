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
				'className' => $event->event_class
			);
		}
		
		echo json_encode($return_events);
	}
	
	function add(){
		$this->mysmarty->assign('event',$this->load->activeModelReturn('model_calendar_events',array(0)));
		$this->json->setData($this->mysmarty->view('calendar/view',false,true));
		$this->json->outputData();
	}
}

?>
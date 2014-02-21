<?php

class events extends MyM_Controller {
	
	public function __construct(){
		parent::__construct();
		$this->mysmarty->assign('section','events');
	}

	function index($year=0,$month=0){
		$year = ($year==0 ? date('Y') : $year);
		$month = ($month==0 ? date('n') : $month);
		
		//build unix times for first and last days of the month
		$start_time = mktime(0,0,0,$month,1,$year);
		$end_time = mktime(23,59,59,$month,cal_days_in_month(CAL_GREGORIAN, $month, $year),$year);
		
		$this->load->activeModel('model_calendar_events','events',array(NULL,NULL,NULL));
		$events = $this->events->get_events($start_time,$end_time);
		
		$return_events = array();
		
		for($i=1;$i<=cal_days_in_month(CAL_GREGORIAN, $month, $year);$i++){
			$return_events[$i] = array();
		}
		
		foreach($events as $event){
			if(date('n',strtotime($event->start_date))==$month){
				$return_events[date('j',strtotime($event->start_date))][] = array(
					'id' => $event->event_id,
					'title' => $event->title,
					'start_date' => $event->start_date,
					'end_date' => $event->end_date,
					'type' => $event->event_type,
					'all_day' => $event->all_day,
					'class' => $event->event_class,
					'day' => $event->day
				);
			}
		}
		
		if($month==1){
			$this->mysmarty->assign('year_p',array('m'=>12,'y'=>($year-1)));
			$this->mysmarty->assign('year_n',array('m'=>2,'y'=>$year));
		}elseif($month==12){
			$this->mysmarty->assign('year_p',array('m'=>11,'y'=>$year));
			$this->mysmarty->assign('year_n',array('m'=>1,'y'=>($year+1)));
		}else{
			$this->mysmarty->assign('year_p',array('m'=>($month-1),'y'=>$year));
			$this->mysmarty->assign('year_n',array('m'=>($month+1),'y'=>$year));
		}
		
		$this->mysmarty->assign('year',$year);
		$this->mysmarty->assign('month',$month);
		
		$this->mysmarty->assign('events',$return_events);
		
		$this->mysmarty->assign('page_title','Events');
		$this->mysmarty->view('mobile/events/index');
	}
	
	function new_event($day_month=false){
		if($day_month===false){
			$this->load_calendar();
			$month_set = array();
			$year = date('Y');
			$month = date('n');
			$month_set[] = array($month,$year);
			for($i=1;$i<12;$i++){
				if($month!=12){
					$month++;
				}else{
					$month=1;
					$year++;
				}
				$month_set[] = array($month,$year);
			}
			
			$this->mysmarty->assign('month_set',$month_set);
			$this->mysmarty->view('mobile/events/new_calendars');
		}else{
			list($year,$month,$day) = explode('-',$day_month);
			$this->load->activeModel('model_calendar_events','event',array(0));
			
			$this->event->start_date = "$year-".str_pad($month,2,'0',STR_PAD_LEFT).'-'.str_pad($day,2,'0',STR_PAD_LEFT);
			$this->event->end_date = "$year-".str_pad($month,2,'0',STR_PAD_LEFT).'-'.str_pad($day,2,'0',STR_PAD_LEFT);
			
			
			$this->mysmarty->view('mobile/events/view');
		}
	}
	
	function edit($event_id=0){
		$event_id = (!is_numeric($event_id) ? substr($event_id,1) : $event_id);
		$this->load->activeModel('model_calendar_events','event',array($event_id));
		$this->mysmarty->view('mobile/events/view');
	}
	
	function save(){
		$this->load->activeModel('model_calendar_events','event',array($this->input->post('event_id',0)));
		$this->event->title = $this->input->post('title',NULL);
		$this->event->description = $this->input->post('description',NULL);
		$this->event->start_date = $this->input->post('start_date',NULL);
		$this->event->end_date = $this->input->post('end_date',NULL);
		
		$this->event->start_time = $this->input->post('start_time','00:00');
		$this->event->end_time = $this->input->post('end_time','00:00');
		
		$this->event->important = $this->input->post('important',0);
		$this->event->private = $this->input->post('private',0);
		$this->event->all_day = $this->input->post('all_day',1);
		$this->event->tentative = $this->input->post('tentative',0);
		$this->event->repeat = $this->input->post('repeat',0);
		
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
		
		$this->event->save();
		
		redirect('/mobile/events/');
	}
	
	private function load_calendar(){
		$prefs['template'] = '
		{table_open}<table border="0" cellpadding="0" cellspacing="0" style="width:100%;margin-bottom:30px;">{/table_open}
		{cal_cell_start}<td align="center" style="padding: 10px 0;">{/cal_cell_start}
		{cal_cell_no_content}<a href="mobile/events/new_event/{year}-{month}-{day}">{day}</a>{/cal_cell_no_content}
		{cal_cell_no_content_today}<div class="highlight"><a href="mobile/events/new_event/{year}-{month}-{day}">{day}</a></div>{/cal_cell_no_content_today}';
		
		$this->load->library('calendar', $prefs);
	}
}

?>
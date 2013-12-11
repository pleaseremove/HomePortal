<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_Controller extends CI_Controller {

	public function __construct($params = array()){
		parent::__construct($params);
		
		$this->load->library('user_agent');
		if($this->agent->is_mobile()){
			//redirect('/mobile');
		}

		$this->load->library('json');
		
		if (!$this->mylogin->checkLoggedin()){
			if($this->input->post('is_ajax',0)==1)
			{
				$this->json->setMessage('logged_out');
				$this->json->outputData();
			}else{
				redirect('/login/logout');
			}
		}
		
		$this->mysmarty->reset_wrapper();
		$this->mysmarty->assignByRef('currentuser',$this->mylogin->user());
	}
	
	
	function filters($include_where=false,$family_prefix=false,$extra_data=array()){
		$filters = array();
		$data = $this->input->post();
		
		if(is_array($data) && count($data)>0){
		
			$data = array_merge($data,$extra_data);
			
			if(isset($data['filter'])){
				foreach($data['filter'] as $what => $by){
					if($by==='0' || !empty($by)){
						if(is_numeric($by)){
							$filters[] = $what.' = '.$this->db->escape($by);
						}elseif(count(explode(',',$by))>1){
							$bits = explode(',',$by);
							$filters[] = $what.' IN (\''.implode('\',\'',$this->db->escape($bits)).'\')';
						}else{
							$filters[] = $what.' = "'.$this->db->escape($by).'"';
						}
					}
				}
			}
			
		}
		
		$filters[] = ($family_prefix ? $family_prefix.'.' : '').'family_id = '.$this->mylogin->user()->family_id;
		$filters[] = 'deleted = 0';
		
		if(isset($data['date_range_s']) && !empty($data['date_range_s'][key($data['date_range_s'])])){
			$filters[] = '`'.key($data['date_range_s']) .'` >= "'.$data['date_range_s'][key($data['date_range_s'])].'"';
		}
		
		if(isset($data['date_range_e']) && !empty($data['date_range_e'][key($data['date_range_e'])])){
			$filters[] = '`'.key($data['date_range_e']) .'` <= "'.$data['date_range_e'][key($data['date_range_e'])].'"';
		}
		
		return ($include_where ? 'WHERE ':'').implode(' AND ',$filters);
		
	}
	
	function order_by($order_by=''){
		$data = $this->input->post();
		
		if(isset($data['orderby']) && $data['orderby']!=''){
			$order_by = ' ORDER BY '.substr($data['orderby'],0,-1);
		}elseif($order_by!=''){
			$order_by = ' ORDER BY '.$order_by;
		}
		
		return $order_by;
	}
	
	function limit_by($start=0,$count=100){
		$data = $this->input->post();
		if(isset($data['scroll_limit'])){
			$start_count = $data['scroll_limit'];
		}else{
			$start_count = $start;
		}
		return ' LIMIT '.$start_count.','.$count;
	}
	
}

class MyM_Controller extends CI_Controller {

	public function __construct($params = array()){
		parent::__construct($params);
		
		$this->load->library('user_agent');
		if(!$this->agent->is_mobile()){
			//redirect('/');
		}

		if (!$this->mylogin->checkLoggedin()){
			redirect('/mobile/login');
		}
		
		$this->mysmarty->set_wrapper('mobile/index');
		$this->mysmarty->assignByRef('currentuser',$this->mylogin->user());
	}
}

?>
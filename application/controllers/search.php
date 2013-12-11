<?php

class Search extends My_Controller {

	function index(){
		$this->load->model('search_model');
		
		$results = $this->search_model->run_search($this->input->post('search'));
		if($results['count']>0){
			$this->mysmarty->assign('results',$results);
			$this->json->setData($this->mysmarty->view('search_results',false,true));
		}else{
			$this->json->setMessage('No results found');
		}
		$this->json->outputData();
	}
}

?>
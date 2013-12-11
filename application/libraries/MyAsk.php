<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class myAsk {
	
	function myAsk(){
		$this->CI =& get_instance();
		$this->CI->load->library('Mysmarty');
	}
	
	function ask($question = 'No Question Set?',$cancelPath = false){
		
		if (!$cancelPath){
			//Old School Hack!
			$cancelPath = 'javascript:history.go(-1);';	
		}
		
		$this->CI->mysmarty->assign('pageheading','Question');
		$this->CI->mysmarty->assign('question',$question);
		$this->CI->mysmarty->assign('path',$this->CI->uri->uri_string());
		$this->CI->mysmarty->assign('cancel',$cancelPath);
		$this->CI->mysmarty->view('libraries/question');
		exit();
	}
}

?>
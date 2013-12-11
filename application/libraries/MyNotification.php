<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class myNotification {
	var $toastsobj = array();
	var $allowedtypes = array('warning','error','information','success');
	var $persistant = true;
	
	function myNotification(){
		$this->CI =& get_instance();
		$this->CI->load->library('Mysmarty');
		if($toasts = $this->CI->session->flashdata('toastobj')){
			if (is_array($toasts)){
				$this->toastsobj = $toasts;
				$this->setSmartyToast();
			}
		}
	}
	
	function toast($message = 'Message Not Set', $type = 'information'){
		
		$this->toastsobj[] = array	(
									'message' => $message,
									'type' => $type
									);
		$this->setSmartyToast();
			
		if ($this->persistant){
			$this->CI->session->set_flashdata('toastobj',$this->toastsobj);
		}
	}
	
	function clearToasts(){
		$this->CI->mysmarty->assign('toast',false);
		$this->CI->mysmarty->assign('toastobj', false);
		$this->toastsobj = array();
		$this->clearPersistantToasts();
		return true;	
	}
	
	function nonPersistant(){
		$this->persistant = false;
		$this->clearPersistantToasts();
	}
	
	function setPersistant(){
		$this->persistant = true;
	}
	
	function clearPersistantToasts(){
		$this->CI->session->set_flashdata('toastobj',NULL);
		return true;
	}
	
	function setSmartyToast(){
		$this->CI->mysmarty->assign('toast',true);
		$this->CI->mysmarty->assign('toastobj', $this->toastsobj);
		return true;	
	}

}

?>
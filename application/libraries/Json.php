<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Json{
	
	private $data = false;
	private $extra = false;
	private $message = '';
	
	private $fixed = false;
	public function setData($data){
		unset($data->CI);
		$this->data = $data;
	}
	
	public function setExtra($extra){
		$this->extra = $extra;
	}
	
	public function setMessage($message='',$fixed=false){
		$this->message = $message;
		$this->fixed = $fixed;
	}
	
	public function returnData(){
		$return_state = ($this->data ? true : false);
		$json = json_encode(array('state'=>$return_state,'message'=>$this->message,'data'=>$this->data));
		$this->clearData();
		return $json;
	}
	
	public function outputData(){
		if(isset($_POST['is_ajax'])){
			$return_state = ($this->data ? true : false);
			echo json_encode(array('state'=>$return_state,'message'=>$this->message,'message_fixed'=>$this->fixed,'data'=>$this->data,'extra'=>$this->extra));
			$this->clearData();
			exit();
		}else{
			$CI =& get_instance();
			$CI->mysmarty->assign("full_load",$this->data);
			$this->clearData();
			return $CI->mysmarty->display('index.tpl');
		}
	}
	
	public function clearData()
	{
		$this->data = false;
		$this->extra = false;
		$this->message = '';
	}
}

?>

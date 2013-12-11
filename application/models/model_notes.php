<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_notes extends ActiveRecord {
	
	protected $PRIMARYID = 'note_id';
	
	public function created_by(){
		return $this->CI->load->activeModelReturn('model_users',array($this->user_created));
	}
	
	public function updated_by(){
		return $this->CI->load->activeModelReturn('model_users',array($this->user_updated));
	}

}
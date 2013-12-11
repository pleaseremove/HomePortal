<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_tasks extends ActiveRecord {
	
	protected $PRIMARYID = 'task_id';
	
	public function created_by()
	{
		return $this->CI->load->activeModelReturn('model_users',array($this->user_created));
	}

}
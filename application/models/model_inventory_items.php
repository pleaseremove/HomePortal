<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_inventory_items extends ActiveRecord {
	
	protected $PRIMARYID = 'invent_id';
	
	public function container()
	{
		return $this->CI->load->activeModelReturn('model_inventory_containers',array($this->container_id));
	}

}
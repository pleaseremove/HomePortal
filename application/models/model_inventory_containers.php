<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_inventory_containers extends ActiveRecord {
	
	protected $PRIMARYID = 'container_id';
	
	public function location()
	{
		return $this->CI->load->activeModelReturn('model_inventory_locations',array($this->location_id));
	}

}
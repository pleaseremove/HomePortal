<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_contacts_children extends ActiveRecord {
	
	protected $PRIMARYID = 'contacts_child_id';
	
	public function age(){
		if(isset($this->birthday)){
			return floor((date('U') - date('U',strtotime($this->birthday))) / 31557600); 
		}else{
			return '';
		}
	}
	
}
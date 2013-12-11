<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_users extends ActiveRecord {
	
	protected $PRIMARYID = 'users_id';
	
	public function __set($name,$value) {
		switch ($name) {
			case 'password' : $value = $this->_setPassword($value); break;
		}
		
		parent::__set($name,$value);		
	}
	
	private function _setPassword($value){
		if (strlen($value) != 40){
			return sha1(rtrim($value).$this->pass_salt."d72Hs0gtB");
		}
		
		return $value;
	}
	
	public function is_admin(){
		return ($this->is_admin == 1 ? true : false);
	}
}
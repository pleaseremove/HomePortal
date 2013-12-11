<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_money_catagories extends ActiveRecord {
	
	protected $PRIMARYID = 'money_category_id';
	
	function children(){
		$set = $this->CI->load->activeModelReturn('model_money_catagories',array(NULL,'WHERE parent = '.$this->id()));
		
		if($set->num_rows()==0){
			return false;
		}else{
			$item_array = array();
			foreach($set as $item){
				$item_array[] = $item->id();
			}
			
			return implode('%2C',$item_array);
		}
	}

}
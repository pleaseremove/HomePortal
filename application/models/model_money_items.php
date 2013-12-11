<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_money_items extends ActiveRecord {
	
	protected $PRIMARYID = 'item_id';
	
	public function account()
	{
		return $this->CI->load->activeModelReturn('model_money_accounts',array($this->account_id));
	}
	
	public function transactions()
	{
		return $this->CI->load->activeModelReturn('model_money_transactions',array(NULL,'WHERE item_id = '.$this->id()));
	}

}
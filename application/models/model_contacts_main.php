<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_contacts_main extends ActiveRecord {
	
	protected $PRIMARYID = 'contact_id';
	private $emails = false;
	private $addresses = false;
	private $data = false;
	private $related = false;
	private $children = false;
	private $categories = false;
	
	public function emails(){
		if(!$this->emails){
			$this->emails = $this->CI->load->activeModelReturn('model_contacts_emails',array(NULL,'WHERE contact_id = '.$this->id().' ORDER BY `default` DESC, in_use DESC'));
		}
		return $this->emails;
	}
	
	public function addresses(){
		if(!$this->addresses){
			$this->addresses = $this->CI->load->activeModelReturn('model_contacts_addresses',array(NULL,'WHERE contact_id = '.$this->id().' ORDER BY `main` DESC'));
		}
		return $this->addresses;
	}
	
	public function data(){
		if(!$this->data){
			$this->data = $this->CI->load->activeModelReturn('model_contacts_data',array(NULL,' AS cd JOIN contacts_data_types AS cdt ON cd.contact_data_type = cdt.data_type_id WHERE contact_id = '.$this->id().' order by contact_data_type, `default` DESC, in_use DESC'));
		}
		return $this->data;
	}
	
	public function age(){
		return floor((date('U') - date('U',strtotime($this->birthday))) / 31557600); 
	}
	
	public function aniversary(){
		return floor((date('U') - date('U',strtotime($this->aniversary))) / 31557600); 
	}
	
	public function related(){
		if(!$this->related){
			$this->related = $this->CI->load->activeModelReturn('model_contacts_main',array(NULL,NULL,'SELECT cm.* FROM contacts_main AS cm JOIN contacts_relations AS cr ON cr.relation_id = cm.contact_id WHERE cr.contact_id = '.$this->id().' ORDER BY first_name, last_name DESC'));
		}
		return $this->related;
	}
	
	public function children(){
		if(!$this->children){
			$this->children = $this->CI->load->activeModelReturn('model_contacts_children',array(NULL,'WHERE parent_1_id = '.$this->id().' OR parent_2_id = '.$this->id().' ORDER BY name DESC'));
		}
		return $this->children;
	}
	
	public function categories(){
		if(!$this->categories){
			$this->categories = $this->CI->load->activeModelReturn('model_contacts_categories',array(NULL,' AS cc JOIN contacts_category_links AS ccl ON ccl.category_id = cc.category_id WHERE ccl.contact_id = '.$this->id().' ORDER BY description DESC'));
		}
		return $this->categories;
	}
	
	public function cats_selected(){
		$return_array = array();
		foreach($this->CI->db->query('select category_id from contacts_category_links WHERE contact_id = '.$this->id())->result_array() as $line){
			$return_array[] = $line['category_id'];
		}
		return $return_array;
	}

}
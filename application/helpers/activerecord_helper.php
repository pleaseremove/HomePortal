<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
* Active Record interator
*
* @package ActiveRecord
* @category Category
* @author Shaun Forsyth, Craig King
*/

class ActiveRecord implements Iterator, Countable{
	public $CI = null;
	
	private $position = 0;
	private $isActiveRecord = true;
	private $id = false;
	private $where = false;
	private $sql = false;
	private $row = false;
	private $query = false;
	private $error = false;
	
	protected $IDSTYLE = '_id';
	protected $SELECTFIELDS = array();
	protected $PRIMARYID = NULL;
	protected $TABLENAME = NULL;
	protected $SAVED = true;
	protected $TABLE_fields = array();
	protected $DEFAULT_FIELDS = array();
	protected $DB_SETTING = 'default';
	
	public $AllowNakedProperties = false;
	
	public function __construct($id = false,$where = false,$sql = false) {
		$this->CI 			=& get_instance();
		$this->CI->load->helper('inflector');
		
		$this->TABLENAME 	= $this->TABLENAME or $this->TABLENAME = str_ireplace('model_','',get_class($this));
		$this->PRIMARYID 	= $this->PRIMARYID or $this->PRIMARYID = singular($this->TABLENAME).$this->IDSTYLE;
		$this->id			= $id or $this->id;
		$this->where 		= $where or $this->where;
		$this->sql 			= $sql or $this->sql;
		$this->TABLE_fields = $this->db()->list_fields($this->TABLENAME);
				
		if ($this->id){
			$this->loadRecord();
		}elseif($this->where || ($this->id===false && $this->where===false && $this->sql===false)){
			$this->loadWhere();
		}elseif($this->sql){
			$this->isActiveRecord = false;
			$this->load();
		}else{
			if ($this->id === NULL || $this->id === 0  || $this->id === '0'|| $this->id === false){
				$this->loadEmptyRecord();
			}
		}
	}
	
	private function loadRecord(){
		$this->sql = 'SELECT '.$this->fields().' FROM '.$this->TABLENAME.' WHERE '.$this->PRIMARYID.' = '.$this->db()->escape($this->id);
		$this->load();
	}
	
	private function loadWhere(){
		$this->sql = 'SELECT '.$this->fields().' FROM '.$this->TABLENAME.' '.$this->where;
		$this->ActiveStateFromWhere();
		$this->load();
	}
	
	private function loadEmptyRecord(){
		$this->row = new stdClass;
		foreach ($this->TABLE_fields as $fieldname){
			$this->row->{$fieldname} = (isset($this->DEFAULT_FIELDS[$fieldname]) ? $this->DEFAULT_FIELDS[$fieldname] : NULL);
		}
		$this->isActiveRecord = true;
		$this->SAVED = false;
		$this->row->{$this->PRIMARYID} = 0;
	}
	
	private function load(){
		$this->query = $this->db()->query($this->sql);
		if ($this->query){
			$this->query->_data_seek();
			$this->row = $this->query->_fetch_object();
		}else{
			$this->error = $this->db()->_error_message();
			$error = 'ActiveRecord ['.get_class($this).']: There has been a problem with the query ['.$this->error.'] SQL ['.$this->sql.']';
			log_message('error',$error);
		}
	}
	
	private function fields(){
		if (is_array($this->SELECTFIELDS) && count($this->SELECTFIELDS) != 0){
			return implode(','.$this->SELECTFIELDS);
		}else{
			return '*';
		}
	}
	
	private function &db(){
		return $this->CI->databasemanager->getConn($this->DB_SETTING);
	}
	
	private function unset_defaults($object){
		//Check I have something to Unset
		if (empty($this->DEFAULT_FIELDS)) return $object;
		
		if (!is_object($object)) die ('Can\'t unset values on non Object');
		
		foreach ($this->DEFAULT_FIELDS as $field){
			if (!empty($field)){
				unset($object->{$field});	
			}
		}
		
		return $object;
	}
	
	private function activeStateFromWhere(){
		if (preg_match('/^[\s]*(LEFT|RIGHT|JOIN|INNER|OUTER)\s/i',$this->where)){
			$this->isActiveRecord = false;
		}else{
			//SF, This feels dirty, however loading a full SQL tokizer is overkill
			//if this doesn't work, what do you want from me? blood?
						
			//Need to check for union
			$sqlToCheck = $this->where;
			//Remove anything in brackets ()
			while (preg_match('/\((?:[^\(\)]|{[^\(\)}]*\))*\)/'	,$sqlToCheck)){
				$sqlToCheck = preg_replace('/\((?:[^\(\)]|{[^\(\)}]*\))*\)/','',$sqlToCheck);
			}
			//Remove anything in double quotes
			while (preg_match('/(".*?(?<!\\\\)")/'	,$sqlToCheck)){
				$sqlToCheck = preg_replace('/(".*?(?<!\\\\)")/','',$sqlToCheck);
			}
			while (preg_match('/(\'.*?(?<!\\\\)\')/'	,$sqlToCheck)){
				$sqlToCheck = preg_replace('/(\'.*?(?<!\\\\)\')/','',$sqlToCheck);
			}
			
			if (preg_match('/UNION/i',$sqlToCheck)){
				$this->isActiveRecord = false;
			}else{
				$this->isActiveRecord = true;
			}
		}
	}
	
	private function logError($showError = false,$message = false){
		if (!$this->isNew()){
			$this->error = $this->db()->_error_message();
		}else{
			$this->error = print_r(debug_backtrace(),true);
		}
		$error = $message or 'ActiveRecord ['.get_class($this).']: There has been a problem with the query ['.$this->error.']';
		log_message('error',$error);
		
		if ($showError) show_error($error);
	}
	
	// Active Record Functions
	// ===================================
	
	public function save(){
		if ($this->SAVED) return true;
		
		if ($this->isActiveRecord){
			$toSave = new stdClass;
			
			foreach ($this->TABLE_fields as $fieldname){
				if ((isset($this->row->{$fieldname}) &&  $this->row->{$fieldname} !== false)  || $this->row->{$fieldname} === NULL){
					$toSave->{$fieldname} = $this->row->{$fieldname};
				}else{
					$toSave->{$fieldname} = NULL;
				}
			}
			
			//Remove ID Field From $toSave Object;
			unset($toSave->{$this->PRIMARYID});
			
			if ($this->isNew()){
				//now loading them form the model... seems to be the only way as sqlsvr use's expression for the default value which get messed up when using
				//GET_DATE();
				//$toSave = $this->unset_defaults($toSave);
				if ($this->db()->insert($this->TABLENAME,$toSave)){
					$this->row->{$this->PRIMARYID} = $this->db()->insert_id();
					$this->SAVED = true;
					return true;
				}
				
				$this->logError();
				
				return false;
			}else{
				if($this->db()->update($this->TABLENAME,$toSave,array($this->PRIMARYID => $this->id()))){
					$this->SAVED = true;
					return true;
				}
				
				$this->logError();
				
				return false;
			}
		}else{
			return false;
		}
		
		return false;
	}
	
	public function delete(){
		if ($this->isActiveRecord){
			if($this->db()->delete($this->TABLENAME,array($this->PRIMARYID => $this->id()))){
				$this->loadEmptyRecord();
				return true;
			}
			
			$this->logError();
			
			return false;
		}else{
			return false;
		}
		
		return true;
	}
	
	public function __get($name) {
		if ($this->__isset($name) || (property_exists($this->row,$name) && $this->row->{$name} === NULL)){
			return $this->row->{$name};
		}
	}
	
	public function __set($name,$value) {
		$this->SAVED = false;
		
		if ($this->__isset($name) || (property_exists($this->row,$name) && $this->row->{$name} === NULL) || $this->AllowNakedProperties == true){
			$this->row->{$name} = $value;
		}else{
			$this->logError(true,'ActiveRecord ['.get_class($this).']: doesn\'t have the property '.$name.' on table '.$this->TABLENAME);
		}
	}
	
	public function __isset($name){
		return property_exists($this->row,$name) && isset($this->row->{$name});
	}
	
	// END================================
	// Active Record Functions
	
	
	// Utilitiy Functions
	// ===================================
	
	public function num_rows(){
		if ($this->query){
			return $this->query->num_rows();	
		}
		
		return 0;
	}
	
	public function moveNext(){
		if($this->valid()){
			if($this->next()){
				return true;
			}
		}
			
		return false;
	}
	
	public function id(){
		if ($this->isNew()){
			return 0;
		}
		
		if(isset($this->row->{$this->PRIMARYID})){
			return $this->row->{$this->PRIMARYID};
		}
		
		return false;
	}
	
	public function moveFirst($load_data = false){
		$this->position = 0;
		$this->query->_data_seek($this->position);
		if($load_data){
			$this->row = $this->query->_fetch_object();
		}
		
		return true;
	}
	
	public function isNew(){
		if(!isset($this->row->{$this->PRIMARYID}) || $this->row->{$this->PRIMARYID}===0 || $this->row->{$this->PRIMARYID}===NULL){
			return true;
		}else{
			return false;
		}
	}
	
	public function getSQL(){
		return $this->sql;
	}
	
	public function dump(){
		$copyme = $this;
		unset($copyme->CI);
		var_dump($copyme);
		unset($copyme);
	}
	
	public function rowArray(){
		return get_object_vars($this->row);
	}
	
	// END================================
	// Utilitiy Functions


	
	// Interface Functions
	// ===================================
    public function rewind() {
			$this->position = 0;
			$this->query->_data_seek($this->position);
			$this->row = $this->query->_fetch_object();
			$this->SAVED = true;
    }

    public function &current() {
    	return $this;
    }

    public function key() {
    	return $this->position;
    }

    public function next() {
			++$this->position;
			if ($this->row = $this->query->_fetch_object()){
				$this->SAVED = true;
				return true;
			}
			
			return false;
    }

    public function valid() {
        return $this->position <= ($this->num_rows()-1);
    }
	
	public function count(){
		return $this->num_rows();
	}
	// END================================
	// Interface Functions
	
}

?>
<?php  if (!defined('BASEPATH')) exit('No direct script access allowed');

/* Used to keep connections under control for Helper_activerecord */

class DatabaseManager {
	private $CI = null;
	private $conns = array();
	
	
	public function __construct(){
		$this->CI =& get_instance();
		
		$this->conns['default'] =& $this->CI->db;
	}
	
	public function &getConn($ConnGroupName = 'default'){
		//Already loaded so return it
		if (isset($this->conns[$ConnGroupName]) && is_object($this->conns[$ConnGroupName])) return $this->conns[$ConnGroupName];
		
		//Load another set, add it to the stack and return it
		$this->conns[$ConnGroupName] =& $this->CI->load->database($ConnGroupName,TRUE);
		
		return $this->conns[$ConnGroupName];
	}
	
	public function __destruct(){
		foreach ($this->conns as $conn){
			$conn->close();	
		}
	}
}

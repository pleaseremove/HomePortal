<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

require "Smarty-3.1.17/libs/Smarty.class.php";

/**
* @file system/application/libraries/Mysmarty.php
*/
class Mysmarty extends Smarty{
	var $wrapper = false; //Remeber to add the .tpl
	var $defaultwrapper = true;
	
	function Mysmarty(){
		parent::__construct();

		$config =& get_config();
		
		// absolute path prevents "template not found" errors
		$this->template_dir = (!empty($config['smarty_template_dir']) ? $config['smarty_template_dir'] 
																	  : BASEPATH . '../application/views/');
																	
		$this->compile_dir  = (!empty($config['smarty_compile_dir']) ? $config['smarty_compile_dir'] 
																	 : BASEPATH . 'cache'); //use CI's cache folder        
		
		$this->defaultwrapper = $this->wrapper;
		$this->error_reporting = E_ALL & ~E_NOTICE;
		
		global $CI;
		$this->assignByRef("ci", $CI);
	}
	
	function set_wrapper($resource_name='default.tpl'){
		if (strpos($resource_name, '.') === false && $resource_name !== false) {
			$resource_name .= '.tpl';
		}
		
		$this->wrapper = $resource_name;
		
		return true;
	}
	
	function reset_wrapper(){
		$this->wrapper = $this->defaultwrapper;	
	}
	
	function view($resource_name, $params = array(), $returntemplate = false)   {
		if (strpos($resource_name, '.') === false) {
			$resource_name .= '.tpl';
		}
		
		if (isset($params) && is_array($params) && count($params)) {
			foreach ($params as $key => $value) {
				$this->assign($key, $value);
			}
		}
		
		// check if the template file exists.
		if (!is_file($this->template_dir[0] . $resource_name)) {
			show_error("template: [$resource_name] cannot be found.");
		}
		
		if ($this->wrapper === false){
			if($returntemplate === TRUE){
				return $this->fetch($resource_name);
			}else{
				return $this->display($resource_name);
			}
		}else{
		
			$this->assign("inner_template",$this->fetch($resource_name));
		 	if($returntemplate === TRUE){
				return $this->fetch($this->wrapper);
			}else{
				return $this->display($this->wrapper);
			}
		}
	}
} // END class smarty_library
?>
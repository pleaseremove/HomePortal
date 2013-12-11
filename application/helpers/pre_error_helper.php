<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

if ( ! function_exists('format_error')){
	function format_error($error,$statusCode = 500){
		if (is_array($error)){
			$error = print_r($error,true);	
		}
		show_error('<pre>'.$error.'</pre>',$statusCode);
	}
}
?>
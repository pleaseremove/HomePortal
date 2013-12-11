<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class MY_Input extends CI_Input {
	
	function post($index = NULL, $default = FALSE, $xss_clean = FALSE)
	{
		if (isset($_POST[$index]) && is_string($_POST[$index]) && $_POST[$index]!=='0' && empty($_POST[$index])) return $default;
		
		$value = parent::post($index,$xss_clean);
		if($value===FALSE)
		{
			return $default;
		}
		
		return $value;
	}
	
	function get($index = NULL, $default = FALSE, $xss_clean = FALSE)
	{
		if (isset($_GET[$index]) && is_string($_GET[$index]) && $_GET[$index]!=='0' && empty($_GET[$index])) return $default;
		
		$value = parent::get($index,$xss_clean);
		if($value===FALSE)
		{
			return $default;
		}
		
		return $value;
	}
	
	function get_post($index = '',$default = FALSE, $xss_clean = FALSE)
	{
		if ( ! isset($_POST[$index]) )
		{
			return $this->get($index, $default, $xss_clean);
		}
		else
		{
			return $this->post($index, $default, $xss_clean);
		}
	}
	
}
<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class MY_Profiler extends CI_Profiler {

	protected function _compile_config()
	{
		$output  = "\n\n";
		$output .= '<fieldset id="ci_profiler_config" style="border:1px solid #000;padding:6px 10px 10px 10px;margin:20px 0 20px 0;background-color:#eee">';
		$output .= "\n";
		$output .= '<legend style="color:#000;">&nbsp;&nbsp;'.$this->CI->lang->line('profiler_config').'&nbsp;&nbsp;(<span style="cursor: pointer;" onclick="var s=document.getElementById(\'ci_profiler_config_table\').style;s.display=s.display==\'none\'?\'\':\'none\';this.innerHTML=this.innerHTML==\''.$this->CI->lang->line('profiler_section_show').'\'?\''.$this->CI->lang->line('profiler_section_hide').'\':\''.$this->CI->lang->line('profiler_section_show').'\';">'.$this->CI->lang->line('profiler_section_show').'</span>)</legend>';
		$output .= "\n";

		$output .= "\n\n<table style='width:100%; display:none' id='ci_profiler_config_table'>\n";

		foreach ($this->CI->config->config as $config=>$val)
		{
			if (is_array($val))
			{
				$val = print_r($val, TRUE);
			}elseif(is_object($val)){
				$val = print_r(get_object_vars($val),true);
			}

			$output .= "<tr><td style='padding:5px; vertical-align: top;color:#900;background-color:#ddd;'>".$config."&nbsp;&nbsp;</td><td style='padding:5px; color:#000;background-color:#ddd;'>".htmlspecialchars($val)."</td></tr>\n";
		}

		$output .= "</table>\n";
		$output .= "</fieldset>";

		return $output;
	}
}
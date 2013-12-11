<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class My_Loader extends CI_Loader {


	public function activeModel($model,$name = '',$params = array()){
		//Params is a indexed array for ActiveRecord Class Constructor
		// 0 = id, 1=where, 2=sql
		if (empty($model)){
			return;
		}
		
		$path = '';

		// Is the model in a sub-folder? If so, parse out the filename and path.
		if (($last_slash = strrpos($model, '/')) !== FALSE){
			// The path is in front of the last slash
			$path = substr($model, 0, $last_slash + 1);

			// And the model name behind it
			$model = substr($model, $last_slash + 1);
		}

		if ($name == '' || $name == NULL || $name == false){
			$name = $model;
		}
		
		if (in_array($name, $this->_ci_models, TRUE)){
			return;
		}
		
		$CI =& get_instance();
		if (isset($CI->$name)){
			show_error('The model name you are loading is the name of a resource that is already being used: '.$name);
		}
		
		$model = strtolower($model);
		
		foreach ($this->_ci_model_paths as $mod_path){
			if ( ! file_exists($mod_path.'models/'.$path.$model.'.php')){
				continue;
			}

			if ( ! class_exists('CI_Model')){
				load_class('Model', 'core');
			}

			require_once($mod_path.'models/'.$path.$model.'.php');

			$model = ucfirst($model);
			
			$model = new ReflectionClass($model);
			
			$CI->$name = $model->newInstanceArgs($params);

			$this->_ci_models[] = $name;
			return;
		}
		
		// couldn't find the model
		show_error('Unable to locate the model you have specified: '.$model);
	}
	
	public function activeModelReturn($model,$params = array()){
		//Params is a indexed array for ActiveRecord Class Constructor
		// 0 = id, 1=where, 2=sql
		if (empty($model)){
			return;
		}
		
		$path = '';

		// Is the model in a sub-folder? If so, parse out the filename and path.
		if (($last_slash = strrpos($model, '/')) !== FALSE){
			// The path is in front of the last slash
			$path = substr($model, 0, $last_slash + 1);

			// And the model name behind it
			$model = substr($model, $last_slash + 1);
		}

		$model = strtolower($model);
		
		foreach ($this->_ci_model_paths as $mod_path){
			if ( ! file_exists($mod_path.'models/'.$path.$model.'.php')){
				continue;
			}

			if ( ! class_exists('CI_Model')){
				load_class('Model', 'core');
			}

			require_once($mod_path.'models/'.$path.$model.'.php');

			$model = ucfirst($model);
			
			$model = new ReflectionClass($model);
			
			return $model->newInstanceArgs($params);
		}
		
		// couldn't find the model
		show_error('Unable to locate the model you have specified: '.$model);
	}
	
}
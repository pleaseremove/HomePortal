<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class myLogin {
	
	var $user = false;
	
	function __construct(){
		$this->CI =& get_instance();
	}
	
	function checkLoggedin(){
		if ($this->CI->session->userdata('userid')){
			if (!$this->user){
				$this->user =& $this->CI->load->activeModelReturn('model_users',array($this->CI->session->userdata('userid')));
				if (!$this->user->num_rows()==1) return false;
			}
			return true;
		}

		return false;
	}
	
	function login($username=false,$password=false){
		if (isset($username) && !empty($username) && isset($password) && !empty($password)){
			
			$this->CI->load->activeModel('model_users','model_user',array(null,'where username = '.$this->CI->db->escape(trim($username))));
			
			if ($this->CI->model_user->num_rows() == 1){
				$hash = sha1(rtrim($password).$this->CI->model_user->pass_salt."d72Hs0gtB");
				if ($hash == $this->CI->model_user->pass_hash){
					$this->user =& $this->CI->model_user;
					$this->CI->session->set_userdata('userid',$this->user->id());
					$this->CI->session->set_userdata('is_admin',$this->user->is_admin);
					return true;
				}else{
					return false;
				}
			}
		}
		return false;
	}
	
	function &user(){
		return $this->user;
	}
	
	function resetpassword($email){
		if (isset($email) && !empty($email)){
			
			$this->CI->load->activeModel('model_users','model_user',array(null,'where email = '.$this->CI->db->escape(trim($email))));
			if($this->CI->model_user->num_rows() == 1){
				//Generate New Password
				$this->CI->load->helper('string');
				$plainpassword = random_string('alnum', 6).'-'.random_string('numeric',4);
				
				$old_salt = $this->CI->model_user->salt;
				$old_password = $this->CI->model_user->password;
				
				$this->CI->model_user->salt = md5(uniqid(time(),true));
				$this->CI->model_user->password = $plainpassword;
										
				if ($this->CI->model_user->save()){ 
					$this->CI->load->helper('email');
					if (valid_email($this->CI->model_user->email)){
						$this->CI->mysmarty->wrapper = false;
						$email = $this->CI->mysmarty->view('email/password_reset',array('password' => $plainpassword),true);
						$this->CI->mysmarty->reset_wrapper();
													
						$this->CI->load->library('email');
						$this->CI->email->from($this->CI->site->email->default_from,'Password Reset');
						$this->CI->email->to($this->CI->model_user->email);
						$this->CI->email->subject($this->CI->site->email->password_subject);
						$this->CI->email->message($email);
						if ($this->CI->email->send()){
							return true;
						}else{
							//Failed, Reset Password Back
							$this->CI->model_user->salt = $old_salt;
							$this->CI->model_user->password = $old_password;
							if (!$this->CI->model_user->save()) show_error('Unexpected Problem In Password Reset Logic, Password Not Reset');
						}
					}
				}
			}
		}
		
		return false;
	}
	
	function logout(){
		$this->CI->session->sess_destroy();
		return true;
	}
}

?>
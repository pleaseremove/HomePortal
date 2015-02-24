<?PHP
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$config['site'] = (object) array (
					'display' => (object) array(
									'title' => 'HomePortal',
								),
					'email' => (object) array(
									'default_from' => 'homeportal@server',
									'password_subject' => 'HomePortal - Password Reset'
								),
					'files' => (object) array (
									'filestore' => $_SERVER['DOCUMENT_ROOT'].'/../filestore/',
								),
					'settings' => (object) array (
						'home' => '/dashboard',
						'mobile_home' => '/mobile',
					)
);

$CI =& get_instance();
$CI->site = &$config['site'];

?>
<?php

class Contacts extends My_Controller {

	function all(){
		$this->mysmarty->assign('contacts',$this->load->activeModelReturn('model_contacts_main',array(NULL,NULL,'
			SELECT
				cm.*,
				(select `data` from contacts_data where contacts_data.contact_id = cm.contact_id and contact_data_type = 1 and in_use = 1 and `default` = 1) AS home_phone,
				(select `data` from contacts_data where contacts_data.contact_id = cm.contact_id and contact_data_type = 2 and in_use = 1 and `default` = 1) AS mobile_phone,
				(select email from contacts_emails where contacts_emails.contact_id = cm.contact_id and contacts_emails.`default` = 1) AS email,
				(select `data` from contacts_data where contacts_data.contact_id = cm.contact_id and contact_data_type = 4 and in_use = 1 and `default` = 1) AS facebook,
				(SELECT COUNT(*) from contacts_sms WHERE contacts_sms.contact_id = cm.contact_id AND contacts_sms.user_id = '.$this->mylogin->user()->id().') AS sms_count
			FROM contacts_main AS cm
			left join contacts_category_links as ccl
				on cm.contact_id = ccl.contact_id
			'.$this->filters(true).' AND (private = 0 OR created_by = '.$this->mylogin->user()->id().')
			GROUP BY cm.contact_id'.$this->order_by('first_name, last_name DESC').$this->limit_by()
		)));
		
		$categories = $this->load->activeModelReturn('model_contacts_categories',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY description ASC'));
		$categories_array[''] = 'All';
		foreach($categories as $category){
			$categories_array[$category->id()] = $category->description;
		}
		
		$this->mysmarty->assign('section_title','Contacts: All');
		
		//$this->mysmarty->assign('delete','/contacts/delete/');
		
		$this->mysmarty->assign('title_buttons',array('
			<a href="contacts/add" class="model inline_button" data-width="800" data-height="650" data-menu-click="contacts" data-selection="contacts-add" class="model inline_button">Add Contact</a>'
		));
		
		$this->mysmarty->assign('filters',array(
			array(
				'label' => 'Private','name' => 'private','type' => 'select','options' => array(
					'' => 'All',
					'1' => 'Private',)
			),
			array(
				'label' => 'Category','name' => 'category_id','type' => 'select','options' => $categories_array
			)
		));
		
		$this->mysmarty->assign('headers',array(
			array('label'=>'First Name','sort'=>'first_name'),
			array('label'=>'Last Name','sort'=>'last_name'),
			array('label'=>'Birthday','sort'=>'birthday'),
			array('label'=>'Mobile','sort'=>'mobile_phone'),
			array('label'=>'Home','sort'=>'home_phone'),
			array('label'=>'E-mail','sort'=>'email'),
			array('label'=>'Facebook'),
			array('label'=>'Text Messages','sort'=>'sms_count')
		));
		
		$this->mysmarty->assign('inner_loop','contacts/all');
		
		$this->json->setData($this->mysmarty->view('data_grid',false,true));
		$this->json->outputData();
	}
	
	function filter(){
		$this->mysmarty->assign('contacts',$this->load->activeModelReturn('model_contacts_main',array(NULL,NULL,'
			SELECT cm.*,
				(select `data` from contacts_data where contacts_data.contact_id = cm.contact_id and contact_data_type = 1 and in_use = 1 and `default` = 1) AS home_phone,
				(select `data` from contacts_data where contacts_data.contact_id = cm.contact_id and contact_data_type = 2 and in_use = 1 and `default` = 1) AS mobile_phone,
				(select email from contacts_emails where contacts_emails.contact_id = cm.contact_id and contacts_emails.`default` = 1) AS email,
				(select `data` from contacts_data where contacts_data.contact_id = cm.contact_id and contact_data_type = 4 and in_use = 1 and `default` = 1) AS facebook,
				(SELECT COUNT(*) from contacts_sms WHERE contacts_sms.contact_id = cm.contact_id AND contacts_sms.user_id = '.$this->mylogin->user()->id().') AS sms_count
			FROM contacts_main AS cm
			left join contacts_category_links as ccl 
				on cm.contact_id = ccl.contact_id
			'.$this->filters(true).' AND (private = 0 OR created_by = '.$this->mylogin->user()->id().')
			GROUP BY cm.contact_id'.$this->order_by('first_name, last_name DESC').$this->limit_by()
		)));
		
		$this->json->setData($this->mysmarty->view('contacts/all',false,true));
		$this->json->outputData();
	}
	
	function view($id=0){
		if($id!=0){
			$this->mysmarty->assign('contact',$this->load->activeModelReturn('model_contacts_main',array($id)));
			$this->json->setData($this->mysmarty->view('contacts/view',false,true));
		}else{
			$this->json->setMessage('Unknown Contact');
		}
		
		$this->json->outputData();
	}
	
	function edit($id){
		if($id!=0){
			$this->mysmarty->assign('contact',$this->load->activeModelReturn('model_contacts_main',array($id)));
			$this->mysmarty->assign('data_types',$this->load->activeModelReturn('model_contacts_data_types',array(NULL,'ORDER BY data_type_name')));
			$this->mysmarty->assign('contact_titles',$this->load->activeModelReturn('model_contacts_titles',array(NULL,'ORDER BY title')));
			$this->mysmarty->assign('groups',$this->load->activeModelReturn('model_contacts_categories',array(NULL,'ORDER BY description ASC')));
			$this->mysmarty->assign('contacts',$this->load->activeModelReturn('model_contacts_main',array(NULL,'ORDER BY first_name, last_name ASC')));
			$this->json->setData($this->mysmarty->view('contacts/edit',false,true));
		}else{
			$this->json->setMessage('Unknown Contact');
		}
		$this->json->outputData();
	}
	
	function add(){
		$this->mysmarty->assign('contact',$this->load->activeModelReturn('model_contacts_main',array(0)));
		$this->mysmarty->assign('data_types',$this->load->activeModelReturn('model_contacts_data_types',array(NULL,'ORDER BY data_type_name')));
		$this->mysmarty->assign('contact_titles',$this->load->activeModelReturn('model_contacts_titles',array(NULL,'ORDER BY title')));
		$this->mysmarty->assign('groups',$this->load->activeModelReturn('model_contacts_categories',array(NULL,'ORDER BY description ASC')));
		$this->mysmarty->assign('contacts',$this->load->activeModelReturn('model_contacts_main',array(NULL,'ORDER BY first_name, last_name ASC')));
		$this->json->setData($this->mysmarty->view('contacts/edit',false,true));
		$this->json->outputData();
	}
	
	function save(){
		//$this->output->enable_profiler(TRUE);
		$contact = $this->load->activeModelReturn('model_contacts_main',array($this->input->post('contact_id',0)));
		$contact->first_name 	=  $this->input->post('first_name',NULL);
		$contact->last_name 	= $this->input->post('last_name',NULL);
		$contact->title_id 		= $this->input->post('title_id',NULL);
		$contact->other_names = $this->input->post('other_names',NULL);
		$contact->gender 			= $this->input->post('gender',NULL);
		$contact->birthday		= $this->input->post('birthday',NULL);
		$contact->aniversary 	= $this->input->post('aniversary',NULL);
		$contact->private 		= $this->input->post('private',0);
		$contact->notes 			= $this->input->post('notes',NULL);
		
		$contact->datetime_updated = date('Y-m-d H:i:s');
		$contact->updated_by = $this->mylogin->user()->id();
		
		if($contact->isNew()){
			$contact->family_id = $this->mylogin->user()->family_id;
			$contact->datetime_created = date('Y-m-d H:i:s');
			$contact->created_by = $this->mylogin->user()->id();
			$contact->deleted = 0;
		}
		
		if($contact->save()){
			
			//group links
			if(isset($_POST['groups'])){
				if($this->db->query('DELETE FROM contacts_category_links WHERE contact_id = '.$contact->id())){
					foreach($_POST['groups'] as $group_id => $v){
						$this->db->query('INSERT INTO contacts_category_links (contact_id,category_id) VALUES ('.$contact->id().','.$group_id.')');
					}
				}
			}
			
			//emails
			if(isset($_POST['email_value'])){
				if($this->db->query('DELETE FROM contacts_emails WHERE contact_id = '.$contact->id())){
					foreach($_POST['email_value'] as $email_id => $email){
						if(!empty($email)){
							$this->db->query('INSERT INTO contacts_emails (`contact_id`, `email`, `in_use`, `default`) VALUES ('.$contact->id().','.$this->db->escape($email).','.(isset($_POST['email_in_use'][$email_id]) ? 1 : 0).','.((isset($_POST['email_value_default']) && $_POST['email_value_default'] == $email_id) ? 1 : 0).')');
						}
					}
				}
			}
			
			//data
			if(isset($_POST['data_types'])){
				if($this->db->query('DELETE FROM contacts_data WHERE contact_id = '.$contact->id())){
					foreach($_POST['data_type_value'] as $data_id => $data){
						if(!empty($data)){
							$this->db->query('INSERT INTO contacts_data (`contact_id`, `contact_data_type`, `data`, `in_use`, `default`) VALUES ('.$contact->id().','.$this->db->escape($_POST['data_types'][$data_id]).','.$this->db->escape($data).','.(isset($_POST['data_type_in_use'][$data_id]) ? 1 : 0).','.((isset($_POST['data_type_default'][$_POST['data_types'][$data_id]]) && $_POST['data_type_default'][$_POST['data_types'][$data_id]] == $data_id) ? 1 : 0).')');
						}
					}
				}
			}
			
			//addresses
			if(isset($_POST['address_name'])){
				if($this->db->query('DELETE FROM contacts_addresses WHERE contact_id = '.$contact->id())){
					foreach($_POST['address_name'] as $add_id => $name){
						if(!empty($name)){
							$this->db->query('
								INSERT INTO contacts_addresses
									(`contact_id`, `name`, `building`, `house`, `road`, `locality`, `town`, `county`, `postcode`, `country`, `main`)
								VALUES
									('.$contact->id().','.
									$this->db->escape($this->null_for_e($_POST['address_name'][$add_id])).','.
									$this->db->escape($this->null_for_e($_POST['address_building'][$add_id])).','.
									$this->db->escape($this->null_for_e($_POST['address_house'][$add_id])).','.
									$this->db->escape($this->null_for_e($_POST['address_road'][$add_id])).','.
									$this->db->escape($this->null_for_e($_POST['address_locality'][$add_id])).','.
									$this->db->escape($this->null_for_e($_POST['address_town'][$add_id])).','.
									$this->db->escape($this->null_for_e($_POST['address_county'][$add_id])).','.
									$this->db->escape($this->null_for_e($_POST['address_postcode'][$add_id])).','.
									$this->db->escape($this->null_for_e($_POST['address_country'][$add_id])).','.
									((isset($_POST['address_default']) && $_POST['address_default']==$add_id) ? 1 : 0).')');
						}
					}
				}
			}
			
			//relations
			if(isset($_POST['related_contact'])){
				if($this->db->query('DELETE FROM contacts_relations WHERE (contact_id = '.$contact->id().') OR (relation_id = '.$contact->id().')')){
					foreach($_POST['related_contact'] as $rel_id => $rel){
						if($rel != 0){
							$this->db->query('INSERT INTO contacts_relations (contact_id,relation_id) VALUES ('.$contact->id().','.$rel.')');
    					$this->db->query('INSERT INTO contacts_relations (contact_id,relation_id) VALUES ('.$rel.','.$contact->id().')');
						}
					}
				}
			}
			
			//contact photo upload
			if(isset($_FILES)){
				$up_cnf['upload_path'] = './_images/contact_photos/';
				$up_cnf['allowed_types'] = 'gif|jpg|png';
				$this->load->library('upload', $up_cnf);
				
				if(!$this->upload->do_upload('contact_photo')){
					//print_r($this->upload->display_errors());
				}else{
					$image_data = $this->upload->data();
					
					//decide if we need a resize
					if($image_data['image_width'] > 150 || $image_data['image_height'] > 200){
						$rs_cnf['image_library'] = 'gd2';
						$rs_cnf['source_image'] = $image_data['full_path'];
						$rs_cnf['create_thumb'] = TRUE;
						$rs_cnf['maintain_ratio'] = TRUE;
						$rs_cnf['width'] = 150;
						$rs_cnf['height'] = 200;
						
						$this->load->library('image_lib', $rs_cnf);
						$this->image_lib->resize();
					}
					
					$contact->picture = $image_data['file_name'];
					if(!$contact->save()){
						$this->json->setData(false);
						$this->json->setMessage('Contact saved but image failed');
						$this->json->outputData();
					}
				}
			}
			
			$this->json->setData(true);
			$this->json->setMessage('Contact Saved');
		}else{
			$this->json->setData(false);
			$this->json->setMessage('Failed to save');
		}

		$this->json->outputData();
	}
	
	private function null_for_e($data_in=''){
		if(!empty($data_in)){
			return $data_in;
		}
		
		return null;
	}
}

?>
<?php

class Search_model extends CI_Model {
  
  function run_search($search_term='',$offset=0, $limit=100)
	{
	  $reselts = $this->db->query("SELECT SQL_CALC_FOUND_ROWS `text`,`type`, `modal`, `link`,`selection`,AVG(`score`) AS `score` FROM (
	  
																	(SELECT
																		  CONCAT(cm.first_name,' ',cm.last_name) AS `text`,
																		  'contact' AS `type`,
																		  'contacts' AS `selection`,
																		  '0' AS `modal`,
																		  CONCAT('/contacts/view/',cm.contact_id) as `link`,
																		  MATCH (cm.first_name,cm.other_names,cm.last_name,cm.notes) AGAINST ('".$this->db->escape_str($search_term)."') as `score`
																		FROM contacts_main AS cm
																		WHERE cm.family_id = ".$this->mylogin->user()->family_id."
																		  AND (cm.private = 0 OR cm.created_by = ".$this->mylogin->user()->id().")
																		  AND MATCH (cm.first_name,cm.other_names,cm.last_name,cm.notes) AGAINST ('".$this->db->escape_str($search_term)."'))
																		  
																	UNION
																	
																	(SELECT
																		  CONCAT(cm.first_name,' ',cm.last_name) AS `text`,
																		  'contact' AS `type`,
																		  'contacts' AS `selection`,
																		  '0' AS `modal`,
																		  CONCAT('/contacts/view/',cm.contact_id) as `link`,
																		  MATCH (ca.name,ca.house,ca.road,ca.town,ca.county,ca.postcode,ca.country) AGAINST ('".$this->db->escape_str($search_term)."') as `score`
																		FROM contacts_main AS cm
																		LEFT JOIN contacts_addresses AS ca
																			ON cm.contact_id = ca.contact_id
																		WHERE cm.family_id = ".$this->mylogin->user()->family_id."
																		  AND (cm.private = 0 OR cm.created_by = ".$this->mylogin->user()->id().")
																		  AND MATCH (ca.name,ca.house,ca.road,ca.town,ca.county,ca.postcode,ca.country) AGAINST ('".$this->db->escape_str($search_term)."'))
																		
																	UNION
																	
																	(SELECT
																		  CONCAT(cm.first_name,' ',cm.last_name) AS `text`,
																		  'contact' AS `type`,
																		  'contacts' AS `selection`,
																		  '0' AS `modal`,
																		  CONCAT('/contacts/view/',cm.contact_id) as `link`,
																		  MATCH (cd.`data`) AGAINST ('".$this->db->escape_str($search_term)."') as `score`
																		FROM contacts_main AS cm
																		LEFT JOIN contacts_data AS cd
																		  ON cm.contact_id = cd.contact_id
																		LEFT JOIN contacts_data_types AS cdt
																		  ON cd.contact_data_type = cdt.data_type_id
																		WHERE cm.family_id = ".$this->mylogin->user()->family_id."
																		  AND (cm.private = 0 OR cm.created_by = ".$this->mylogin->user()->id().")
																		  AND MATCH (cd.`data`) AGAINST ('".$this->db->escape_str($search_term)."')
																		GROUP BY cm.contact_id)
																		
																	UNION
																	
																	(SELECT
																	  t.name AS `text`,
																	  'task' AS `type`,
																	  'tasks' AS `selection`,
																	  '1' AS `modal`,
																	  CONCAT('/tasks/view/',t.task_id) as `link`,
																	  MATCH (t.name,t.details) AGAINST ('".$this->db->escape_str($search_term)."') as `score`
																	FROM tasks AS t
																	WHERE t.family_id = ".$this->mylogin->user()->family_id."
																		AND (t.private = 0 OR t.user_created = ".$this->mylogin->user()->id().")
																	  AND MATCH (t.name,t.details) AGAINST ('".$this->db->escape_str($search_term)."'))
																	  
																	UNION
																	
																	(SELECT
																	  CONCAT(DAY(start_date),'/',MONTH(start_date),'/',YEAR(start_date),' - ',c.title) AS `text`,
																	  'calendar' AS `type`,
																	  'calendar' AS `selection`,
																	  '1' AS `modal`,
																	  CONCAT('/calendar/event/',c.event_id) as `link`,
																	  MATCH (c.title,c.description,c.location) AGAINST ('".$this->db->escape_str($search_term)."') as `score`
																	FROM calendar_events AS c
																	WHERE c.family_id = ".$this->mylogin->user()->family_id."
																		AND (c.private = 0 OR c.created_by = ".$this->mylogin->user()->id().")
																	  AND MATCH (c.title,c.description,c.location) AGAINST ('".$this->db->escape_str($search_term)."'))
																	
																	UNION
																	
																	(SELECT
																	  CONCAT(mc.description,': ',DAY(mi.date),'/',MONTH(mi.date),'/',YEAR(mi.date),' - ',m.amount) AS `text`,
																	  'money' AS `type`,
																	  'money-all' AS `selection`,
																	  '1' AS `modal`,
																	  CONCAT('/money/transactions/view/',mi.item_id) as `link`,
																	  MATCH (mi.description) AGAINST ('".$this->db->escape_str($search_term)."') as `score`
																	FROM money_transactions AS m
																	JOIN money_items AS mi
																	  ON m.item_id = mi.item_id
																	JOIN money_catagories AS mc
																		ON m.category_id = mc.money_category_id AND mc.top_level = 1
																	WHERE mi.family_id = ".$this->mylogin->user()->family_id."
																	  AND MATCH (mi.description) AGAINST ('".$this->db->escape_str($search_term)."'))
																	  
																	UNION
																	
																	(SELECT
																	  CONCAT(ii.name) AS `text`,
																	  'inventory' AS `type`,
																	  'inventory-items' AS `selection`,
																	  '1' AS `modal`,
																	  CONCAT('/inventory/items/view/',ii.invent_id) as `link`,
																	  MATCH (ii.name,ii.description) AGAINST ('".$this->db->escape_str($search_term)."') as `score`
																	FROM inventory_items AS ii
																	WHERE ii.family_id = ".$this->mylogin->user()->family_id."
																	  AND MATCH (ii.name,ii.description) AGAINST ('".$this->db->escape_str($search_term)."'))
																	  
																	UNION
																	
																	(SELECT
																	  n.name AS `text`,
																	  'note' AS `type`,
																	  'notes' AS `selection`,
																	  '1' AS `modal`,
																	  CONCAT('/notes/view/',n.note_id) as `link`,
																	  MATCH (n.name,n.note) AGAINST ('".$this->db->escape_str($search_term)."' IN BOOLEAN MODE) as `score`
																	FROM notes AS n
																	WHERE n.family_id = ".$this->mylogin->user()->family_id."
																		AND (n.private = 0 OR n.user_created = ".$this->mylogin->user()->id().")
																		AND n.deleted = 0
																	  AND MATCH (n.name,n.note) AGAINST ('".$this->db->escape_str($search_term)."' IN BOOLEAN MODE))

																	) AS result_set
																GROUP BY `link`
																ORDER BY AVG(`score`) DESC
																LIMIT ".$offset.",".$limit);
	  $return_data['data'] = $reselts->result_array();
	  $temp = $this->db->query('SELECT FOUND_ROWS() AS row_count');
	  $temp = $temp->row_array();
	  $return_data['count'] = $temp['row_count'];
	  return $return_data;
	}
}

?>
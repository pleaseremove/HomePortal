<?PHP  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class model_calendar_events extends ActiveRecord {
	
	protected $PRIMARYID = 'event_id';
	
	public function get_events($start_unix,$end_unix){
		$sql = "SELECT * FROM (
			SELECT
			  CONCAT('c',event_id) as event_id,
			  event_id as 'rel_id',
			  title,
			  CONCAT(start_date,' ',start_time) as start_date,
			  CONCAT(end_date,' ',end_time) as end_date,
			  'c' as event_type,
			  all_day,
			  IF(important=1,'event_important','event_normal') as event_class,
			  tentative,
			  day(start_date) as `day`
			FROM calendar_events
			WHERE ((start_date >= FROM_UNIXTIME(".$start_unix.") AND end_date <= FROM_UNIXTIME(".$end_unix."))
				OR (end_date >= FROM_UNIXTIME(".$start_unix.") AND start_date <=NOW())
				OR (start_date <= FROM_UNIXTIME(".$end_unix.") AND end_date >=NOW())
				)
			  AND (private = 0 OR created_by = ".$this->CI->mylogin->user()->id().")
		    AND family_id = ".$this->CI->mylogin->user()->family_id."
			
			UNION
			
			SELECT
		   CONCAT('b',contact_id) as event_id,
		   contact_id as 'rel_id',
 		   CONCAT('Birthday: ',first_name,' ',last_name) as title,
		   CONCAT(
		     if(
			     YEAR(FROM_UNIXTIME(".$start_unix."))=YEAR(FROM_UNIXTIME(".$end_unix.")),
			     YEAR(FROM_UNIXTIME(".$start_unix.")),
				   if(
			       MONTH(birthday)=12,
				     YEAR(FROM_UNIXTIME(".$start_unix.")),
				     if(
				       (MONTH(birthday)=1 OR MONTH(birthday)=2),
				       YEAR(FROM_UNIXTIME(".$start_unix."))+1,
				       YEAR(FROM_UNIXTIME(".$start_unix."))
				     )
				   )
			   ),'-',DATE_FORMAT(birthday,'%m-%d %H:%i:%s')
			 ) as start_date,
		   CONCAT(
		     if(
			     YEAR(FROM_UNIXTIME(".$start_unix."))=YEAR(FROM_UNIXTIME(".$end_unix.")),
			     YEAR(FROM_UNIXTIME(".$start_unix.")),
			     if(
			       MONTH(birthday)=12,
				     YEAR(FROM_UNIXTIME(".$start_unix.")),
				     if(
				       (MONTH(birthday)=1 OR MONTH(birthday)=2),
				       YEAR(FROM_UNIXTIME(".$start_unix."))+1,
				       YEAR(FROM_UNIXTIME(".$start_unix."))
				     )
				   )
			   ),'-',DATE_FORMAT(birthday,'%m-%d %H:%i:%s')
			 ) as end_date,
		   'b' as event_type,
		   '1' as all_day,
		   'event_birthday' as event_class,
		   '0' AS tentative,
	     day(birthday) as `day`
		 FROM contacts_main
		 WHERE
		   IF(DAYOFYEAR(FROM_UNIXTIME(".$start_unix.")) < DAYOFYEAR(FROM_UNIXTIME(".$end_unix.")), 
		   (
		     DAYOFYEAR(birthday) >= DAYOFYEAR(FROM_UNIXTIME(".$start_unix."))
		     AND DAYOFYEAR(birthday) <= DAYOFYEAR(FROM_UNIXTIME(".$end_unix."))
		   ),(
		     DAYOFYEAR(birthday) >= DAYOFYEAR(FROM_UNIXTIME(".$start_unix."))
		     OR DAYOFYEAR(birthday) <= DAYOFYEAR(FROM_UNIXTIME(".$end_unix."))
		     )
		   )
		  AND contacts_main.deleted <> 1
		  AND (private = 0 OR created_by = ".$this->CI->mylogin->user()->id().")
		  AND family_id = ".$this->CI->mylogin->user()->family_id."
		  
		  UNION
		  
		  SELECT
		   CONCAT('b',parent_1_id) as event_id,
		   parent_1_id as 'rel_id',
 		   CONCAT('Birthday: ',cc.name) as title,
		   CONCAT(
		     if(
			     YEAR(FROM_UNIXTIME(".$start_unix."))=YEAR(FROM_UNIXTIME(".$end_unix.")),
			     YEAR(FROM_UNIXTIME(".$start_unix.")),
				   if(
			       MONTH(cc.birthday)=12,
				     YEAR(FROM_UNIXTIME(".$start_unix.")),
				     if(
				       (MONTH(cc.birthday)=1 OR MONTH(cc.birthday)=2),
				       YEAR(FROM_UNIXTIME(".$start_unix."))+1,
				       YEAR(FROM_UNIXTIME(".$start_unix."))
				     )
				   )
			   ),'-',DATE_FORMAT(cc.birthday,'%m-%d %H:%i:%s')
			 ) as start_date,
		   CONCAT(
		     if(
			     YEAR(FROM_UNIXTIME(".$start_unix."))=YEAR(FROM_UNIXTIME(".$end_unix.")),
			     YEAR(FROM_UNIXTIME(".$start_unix.")),
			     if(
			       MONTH(cc.birthday)=12,
				     YEAR(FROM_UNIXTIME(".$start_unix.")),
				     if(
				       (MONTH(cc.birthday)=1 OR MONTH(cc.birthday)=2),
				       YEAR(FROM_UNIXTIME(".$start_unix."))+1,
				       YEAR(FROM_UNIXTIME(".$start_unix."))
				     )
				   )
			   ),'-',DATE_FORMAT(cc.birthday,'%m-%d %H:%i:%s')
			 ) as end_date,
		   'b' as event_type,
		   '1' as all_day,
		   'event_birthday' as event_class,
		   '0' AS tentative,
	     day(cc.birthday) as `day`
		 FROM contacts_children AS cc
		 JOIN contacts_main AS cm
		 		ON cc.parent_1_id = cm.contact_id
		 WHERE
		   IF(DAYOFYEAR(FROM_UNIXTIME(".$start_unix.")) < DAYOFYEAR(FROM_UNIXTIME(".$end_unix.")), 
		   (
		     DAYOFYEAR(cc.birthday) >= DAYOFYEAR(FROM_UNIXTIME(".$start_unix."))
		     AND DAYOFYEAR(cc.birthday) <= DAYOFYEAR(FROM_UNIXTIME(".$end_unix."))
		   ),(
		     DAYOFYEAR(cc.birthday) >= DAYOFYEAR(FROM_UNIXTIME(".$start_unix."))
		     OR DAYOFYEAR(cc.birthday) <= DAYOFYEAR(FROM_UNIXTIME(".$end_unix."))
		     )
		   )
		  AND cm.deleted <> 1
		  AND (cm.private = 0 OR cm.created_by = ".$this->CI->mylogin->user()->id().")
		  AND cm.family_id = ".$this->CI->mylogin->user()->family_id."
		  
		  UNION
		  
		  SELECT
		    CONCAT('a',contact_id) as event_id,
		    contact_id as 'rel_id',
 		    CONCAT('Aniversary: ',first_name,' ',last_name) as title,
		    CONCAT(
		      if(
			      YEAR(FROM_UNIXTIME(".$start_unix."))=YEAR(FROM_UNIXTIME(".$end_unix.")),
			      YEAR(FROM_UNIXTIME(".$start_unix.")),
				    if(
			        MONTH(aniversary)=12,
				      YEAR(FROM_UNIXTIME(".$start_unix.")),
				      if(
				        (MONTH(aniversary)=1 OR MONTH(aniversary)=2),
				        YEAR(FROM_UNIXTIME(".$start_unix."))+1,
				        YEAR(FROM_UNIXTIME(".$start_unix."))
				      )
				    )
			    ),'-',DATE_FORMAT(aniversary,'%m-%d %H:%i:%s')
			  ) as start_date,
		    CONCAT(
		      if(
			      YEAR(FROM_UNIXTIME(".$start_unix."))=YEAR(FROM_UNIXTIME(".$end_unix.")),
			      YEAR(FROM_UNIXTIME(".$start_unix.")),
			      if(
			        MONTH(aniversary)=12,
				      YEAR(FROM_UNIXTIME(".$start_unix.")),
				      if(
				        (MONTH(aniversary)=1 OR MONTH(aniversary)=2),
				        YEAR(FROM_UNIXTIME(".$start_unix."))+1,
				        YEAR(FROM_UNIXTIME(".$start_unix."))
				      )
				    )
			    ),'-',DATE_FORMAT(aniversary,'%m-%d %H:%i:%s')
			  ) as end_date,
		    'a' as event_type,
		    '1' as all_day,
		    'event_aniversary' as event_class,
		    '0' AS tentative,
		    day(aniversary) as `day`
		  FROM contacts_main
		  WHERE
		    IF(DAYOFYEAR(FROM_UNIXTIME(".$start_unix.")) < DAYOFYEAR(FROM_UNIXTIME(".$end_unix.")), 
		    (
		      DAYOFYEAR(aniversary) >= DAYOFYEAR(FROM_UNIXTIME(".$start_unix."))
		      AND DAYOFYEAR(aniversary) <= DAYOFYEAR(FROM_UNIXTIME(".$end_unix."))
		    ),(
		      DAYOFYEAR(aniversary) >= DAYOFYEAR(FROM_UNIXTIME(".$start_unix."))
		      OR DAYOFYEAR(aniversary) <= DAYOFYEAR(FROM_UNIXTIME(".$end_unix."))
		      )
		    )
		   AND contacts_main.deleted <> 1
		   AND (private = 0 OR created_by = ".$this->CI->mylogin->user()->id().")
		   AND family_id = ".$this->CI->mylogin->user()->family_id."
		   
		   UNION
		   
		   SELECT
				  CONCAT('t',`task_id`) as event_id,
				  task_id as 'rel_id',
				  CONCAT('Task: ',name) as title,
				  date_due as start_date,
				  date_due as end_date,
				  't' as event_type,
				  '1' as all_day,
				  'event_task' as event_class,
				  '0' AS tentative,
				  day(date_due) as `day`
				 FROM tasks
				 WHERE
				   date_due >= FROM_UNIXTIME(".$start_unix.")
				   AND date_due <= FROM_UNIXTIME(".$end_unix.")
				   AND (private = 0 OR user_created = ".$this->CI->mylogin->user()->id().")
				   AND family_id = ".$this->CI->mylogin->user()->family_id."
		) AS event_data
		ORDER BY start_date
		";
		
		return $this->CI->load->activeModelReturn('model_calendar_events',array(NULL,NULL,$sql));
	}
	
	public function dateToCal($start_end='start') {
		if($start_end=='start'){
			return date('Ymd'.($this->all_day==0 ? '\THis\Z':''), strtotime($this->start_date.''.$this->start_time));
		}else{
			return date('Ymd'.($this->all_day==0 ? '\THis\Z':''), strtotime($this->end_date.''.$this->end_time));
		}
	}
 
	public function escapeStringIcal($string) {
		return preg_replace('/([\,;])/','\\\$1', $string);
	}
	
	/*public function get_events_by_parts($year,$month,$day){
		$sql = "SELECT * FROM (
			SELECT
			  CONCAT('c',event_id) as event_id,
			  event_id as 'rel_id',
			  title,
			  'c' as event_type,
			  all_day,
			  IF(important=1,'event_important','event_normal') as event_class,
			  day(start_date) as `day`
			FROM calendar_events
			WHERE year(start_date) = ".$year." AND month(start_date) = ".$month." AND day(start_date) = ".$day."
			  AND (private = 0 OR created_by = ".$this->CI->mylogin->user()->id().")
		    AND family_id = ".$this->CI->mylogin->user()->family_id."
			
			UNION
			
			SELECT
		   CONCAT('b',contact_id) as event_id,
		   contact_id as 'rel_id',
 		   CONCAT('Birthday: ',first_name,' ',last_name) as title,
		   'b' as event_type,
		   '1' as all_day,
		   'event_birthday' as event_class,
	     	day(birthday) as `day`
		 FROM contacts_main
		 WHERE
		   month(birthday) = ".$month." AND day(birthday) = ".$day."
		  AND contacts_main.deleted <> 1
		  AND (private = 0 OR created_by = ".$this->CI->mylogin->user()->id().")
		  AND family_id = ".$this->CI->mylogin->user()->family_id."
		  
		  UNION
		  
		  SELECT
		    CONCAT('a',contact_id) as event_id,
		    contact_id as 'rel_id',
 		    CONCAT('Aniversary: ',first_name,' ',last_name) as title,
		    'a' as event_type,
		    '1' as all_day,
		    'event_aniversary' as event_class,
		    day(aniversary) as `day`
		  FROM contacts_main
		  WHERE
		   month(aniversary) = ".$month." AND day(aniversary) = ".$day."
		   AND contacts_main.deleted <> 1
		   AND (private = 0 OR created_by = ".$this->CI->mylogin->user()->id().")
		   AND family_id = ".$this->CI->mylogin->user()->family_id."
		   
		   UNION
		   
		   SELECT
				  CONCAT('t',`task_id`) as event_id,
				  task_id as 'rel_id',
				  CONCAT('Task: ',name) as title,
				  't' as event_type,
				  '1' as all_day,
				  'event_task' as event_class,
				  day(date_due) as `day`
				 FROM tasks
				 WHERE
				   year(date_due) = ".$year." AND month(date_due) = ".$month." AND day(date_due) = ".$day."
				   AND (private = 0 OR user_created = ".$this->CI->mylogin->user()->id().")
				   AND family_id = ".$this->CI->mylogin->user()->family_id."
		) AS event_data";
		
		return $this->CI->load->activeModelReturn('model_calendar_events',array(NULL,NULL,$sql));
	}*/
}
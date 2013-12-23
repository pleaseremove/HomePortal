<?php

class Money_stats_model extends CI_Model {
	
	var $start_date = '2012-01-01';
  
  function account_balances($accounts=array())
	{
		
	  $results = $this->db->query('SELECT
			a.name,
			a.`type`,
			a.description,
			ROUND(SUM(IF(mi.date <= DATE(DATE_SUB(NOW(),INTERVAL 1 YEAR)),(mi.trans_type * mt.amount),0)),2) AS `last_year`,
			ROUND(SUM(IF(mi.date <= DATE(DATE_SUB(NOW(),INTERVAL 1 MONTH)),(mi.trans_type * mt.amount),0)),2) AS `last_month`,
			ROUND(SUM(IF(mi.date <= DATE(NOW()),(mi.trans_type * mt.amount),0)),2) AS `this_month`,
			IF(SUM(IF(mi.date <= DATE(NOW()),(mi.trans_type * mt.amount),0)) >= (SUM(IF(mi.date <= DATE(DATE_SUB(NOW(),INTERVAL 1 MONTH)),(mi.trans_type * mt.amount),0))),
				ROUND(ABS(SUM(IF(mi.date <= DATE(NOW()),(mi.trans_type * mt.amount),0)) - SUM(IF(mi.date <= DATE(DATE_SUB(NOW(),INTERVAL 1 MONTH)),(mi.trans_type * mt.amount),0))),2)*1,
				ROUND(ABS(SUM(IF(mi.date <= DATE(NOW()),(mi.trans_type * mt.amount),0)) - SUM(IF(mi.date <= DATE(DATE_SUB(NOW(),INTERVAL 1 MONTH)),(mi.trans_type * mt.amount),0))),2)*-1
			) AS diff
		FROM money_items AS mi
		JOIN money_transactions AS mt
			ON mi.item_id = mt.item_id AND mi.family_id = '.$this->mylogin->user()->family_id.'
		JOIN money_accounts AS a
		  ON a.account_id = mi.account_id
		'.(count($accounts) > 0 ? 'WHERE a.account_id IN('.implode(',',$accounts).')' : 'WHERE a.hide = 0').'
			AND mi.deleted = 0
		GROUP BY mi.account_id');
	  return $results->result_array();
	}
	
	function calc_category_distribution($account_id=false){
		$data = $this->db->query('
			SELECT
				mc2.description,
				ROUND(SUM(mt.amount),2) AS amount,
				mc2.color
			FROM money_transactions AS mt
			JOIN money_items AS mi
				ON mt.item_id = mi.item_id AND mi.family_id = '.$this->mylogin->user()->family_id.'
			JOIN money_catagories AS mc
				ON mt.category_id = mc.money_category_id
			JOIN money_catagories AS mc2
				ON mc.parent = mc2.money_category_id
			WHERE mc.money_category_id NOT IN(SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1)
				AND mi.trans_type = -1
				AND mi.deleted = 0
				'.(isset($account_id) ? ' AND mi.account_id = '.$account_id : '').'
			GROUP BY mc2.money_category_id
		');
		
		return $data->result_array();
	}
	
	function calc_accounts_chart($year=false,$month=false,$accounts=false){
		$year = ($year ? $year : date('Y'));
		$month = ($month ? $month : date('n'));
		$accounts = ($accounts ? $accounts : array());
		
		$sets = array();
		
		//get account details
		$account_set = $this->load->activeModelReturn('model_money_accounts',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' AND hide = 0 '.(count($accounts)>0 ? 'AND account_id IN ('.implode(',',$accounts).')' : '').' ORDER BY name'));
		foreach($account_set as $account_ar){
			$accounts[$account_ar->id()] = array(
				'name' => $account_ar->name,
				'colour' => $account_ar->colour
			);
		}
		
		//number of days
		$day_count = cal_days_in_month(CAL_GREGORIAN, $month, $year);
		$prev_days = ($month==1 ? cal_days_in_month(CAL_GREGORIAN, 1, $year-1) : cal_days_in_month(CAL_GREGORIAN, $month-1, $year));
		$prev_month = ($month==1 ? 12 : $month-1);
		$prev_year = ($month==1 ? $year-1 : $year);
		
		//for each account
		foreach($accounts as $account_id => $data){
			//get starting balance
			$start_balance = $this->load->activeModelReturn('model_money_transactions',array(NULL,NULL,'SELECT ROUND(SUM(mi.trans_type * mt.amount),2) as start_amount FROM money_items AS mi JOIN money_transactions AS mt	ON mi.item_id = mt.item_id WHERE mi.account_id = '.$account_id.' AND mi.family_id = '.$this->mylogin->user()->family_id.' AND mi.`date` BETWEEN "2012-01-01" AND "'.$prev_year.'-'.$prev_month.'-'.$prev_days.'"'));
			
			$balance = $start_balance->start_amount;
			$sql = 'SELECT';
			
			//for each date for that account
			for($i=1;$i<=$day_count;$i++){
				$sql.='(SELECT ROUND(SUM(mi.trans_type * mt.amount),2) FROM money_items AS mi JOIN money_transactions AS mt	ON mi.item_id = mt.item_id WHERE mi.family_id = '.$this->mylogin->user()->family_id.' AND mi.account_id = '.$account_id.' AND YEAR(mi.`date`) = '.$year.' AND MONTH(mi.`date`) = '.$month.' AND DAY(mi.`date`) = '.$i.') AS "day_'.$i.'",';
			}
			
			$data = $this->load->activeModelReturn('model_money_transactions',array(NULL,NULL,substr($sql, 0, -1)));
			
			$count = 1;
			foreach($data->rowArray() as $day){
				if($month==date('n') && $year==date('Y') && $count > date('j')){
					//nothing
				}else{
					$balance = (isset($day) ? $balance + $day : $balance + 0 );
					$sets[$account_id][$count] = $balance;
					$count++;
				}
			}
			
			$sets[$account_id] = implode(',',$sets[$account_id]);
		}
		
		return array('data' =>$sets,'accounts'=>$accounts);
	}
	
	function calc_category_breakdown($year=false,$accounts=false,$inlcude_transfers=false){
		$year = ($year ? $year : date('Y'));
		$accounts = ($accounts ? $accounts : array());
		
		//if no accounts set, get some
		if(count($accounts)==0){
			$account_set = $this->load->activeModelReturn('model_money_accounts',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY name'));
			foreach($account_set as $account_ar){
				$accounts[] = $account_ar->id();
			}
		}
		
		//get top level calegories
		$cats_set = $this->load->activeModelReturn('model_money_catagories',array(NULL,'WHERE top_level = 1 AND family_id = '.$this->mylogin->user()->family_id.' ORDER BY description'));
		foreach($cats_set as $cat){
			$catser_a[] = array('name'=>$cat->description,'colour'=>$cat->color);
			$cat_set[] = $cat->children();//implode(',',$this->db->select('SELECT category_id FROM catagories WHERE parent = '.$cat->id())->result_array());
			$cat_result = $this->db->query('SELECT
				ROUND(SUM(mt.amount),2) AS total,
				MONTH(mi.date) AS `month`
			FROM money_items AS mi
			JOIN money_transactions AS mt
				ON mi.item_id = mt.item_id
			WHERE YEAR(mi.date) = '.$year.'
				AND mi.account_id IN ('.implode(',',$accounts).')
				AND mt.category_id IN(SELECT money_category_id FROM money_catagories WHERE parent = '.$cat->id().')
				AND mi.trans_type = -1
				AND mi.deleted = 0
				AND mi.family_id = '.$this->mylogin->user()->family_id.'
				'.($inlcude_transfers ? '' : 'AND mt.category_id NOT IN(SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1 AND family_id = '.$this->mylogin->user()->family_id.')').'
			GROUP BY MONTH(mi.date)
			ORDER BY MONTH(mi.date)');
			
			foreach($cat_result->result_array() as $res){
				$cat_lines[$cat->description][$res['month']] = $res['total'];
			}
			
			for($i=1;$i<13;$i++){
				if(!isset($cat_lines[$cat->description][$i])){
					$cat_lines[$cat->description][$i] = 0;
				}
			}
		}
		
		$incoming = $this->load->activeModelReturn('model_money_catagories',array(NULL,NULL,'SELECT ROUND(SUM(mt.amount),2) AS amount, MONTH(mi.date) as `month` FROM money_transactions AS mt
				JOIN money_items AS mi
					ON mi.item_id = mt.item_id
				WHERE mi.trans_type = 1
					AND YEAR(mi.date) = '.$year.'
					AND mi.account_id IN ('.implode(',',$accounts).')
					AND mi.family_id = '.$this->mylogin->user()->family_id.'
					AND mt.category_id NOT IN(SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1 AND family_id = '.$this->mylogin->user()->family_id.')
					AND mi.deleted = 0
				GROUP BY MONTH(mi.date)
				ORDER BY MONTH(mi.date)'));
		
		foreach($incoming as $in){
			$in_array[$in->month] = $in->amount;
		}
		
		for($i=1;$i<13;$i++){
			if(!isset($in_array[$i])){
				$in_array[$i] = 0;
			}
		}
		
		return array('out' => $cat_lines,'in' => $in_array, 'cats' => json_encode($cat_set), 'catser' => $catser_a);
	}
	
	function year_cat_breakdown($year=false){
		$year = ($year ? $year : date('Y'));
		
		return $this->load->activeModelReturn('model_money_catagories',array(NULL,NULL,'
		SELECT
			mc2.description AS "Category",
			mc2.target_amount,
			ROUND(SUM(IF(MONTH(mi.date)=1,mt.amount,0)),2) AS "Jan",
			ROUND(SUM(IF(MONTH(mi.date)=2,mt.amount,0)),2) AS "Feb",
			ROUND(SUM(IF(MONTH(mi.date)=3,mt.amount,0)),2) AS "Mar",
			ROUND(SUM(IF(MONTH(mi.date)=4,mt.amount,0)),2) AS "Apr",
			ROUND(SUM(IF(MONTH(mi.date)=5,mt.amount,0)),2) AS "May",
			ROUND(SUM(IF(MONTH(mi.date)=6,mt.amount,0)),2) AS "Jun",
			ROUND(SUM(IF(MONTH(mi.date)=7,mt.amount,0)),2) AS "Jul",
			ROUND(SUM(IF(MONTH(mi.date)=8,mt.amount,0)),2) AS "Aug",
			ROUND(SUM(IF(MONTH(mi.date)=9,mt.amount,0)),2) AS "Sep",
			ROUND(SUM(IF(MONTH(mi.date)=10,mt.amount,0)),2) AS "Oct",
			ROUND(SUM(IF(MONTH(mi.date)=11,mt.amount,0)),2) AS "Nov",
			ROUND(SUM(IF(MONTH(mi.date)=12,mt.amount,0)),2) AS "Dec"
		FROM money_transactions AS mt
		JOIN money_items AS mi
			ON mt.item_id = mi.item_id
		JOIN money_catagories AS mc
			ON mc.money_category_id = mt.category_id
		JOIN money_catagories AS mc2
			ON mc2.money_category_id = mc.parent
		WHERE mc.money_category_id NOT IN (SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1)
			AND mi.trans_type = -1
			AND mi.family_id = '.$this->mylogin->user()->family_id.'
			AND mi.deleted = 0
			AND YEAR(mi.date) = '.$year.'
		GROUP BY mc.parent
		ORDER BY mc2.description'));
	}
	
	function current_month_progress(){
		return $this->load->activeModelReturn('model_money_catagories',array(NULL,NULL,'
			SELECT
				mc2.description AS "category",
				ROUND(SUM(mt.amount),2) AS "spent",
				mc2.target_amount,
				ROUND(((SUM(mt.amount) / mc2.target_amount) * 100)) AS percent,
				(SELECT ROUND(SUM(money_transactions.amount),2) FROM money_transactions JOIN money_items ON money_transactions.item_id = money_items.item_id JOIN money_catagories ON money_catagories.money_category_id = money_transactions.category_id WHERE money_catagories.money_category_id NOT IN (SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1) AND money_catagories.parent = mc.parent AND money_items.trans_type = -1 AND money_items.family_id = 1 AND money_items.date <= DATE_SUB(CURRENT_DATE(),INTERVAL 1 MONTH)	AND MONTH(money_items.date) = MONTH(DATE_SUB(CURRENT_DATE(),INTERVAL 1 MONTH)) AND YEAR(money_items.date) = YEAR(DATE_SUB(CURRENT_DATE(),INTERVAL 1 MONTH))) AS last_month,
				ROUND(((SELECT ROUND(SUM(money_transactions.amount),2) FROM money_transactions JOIN money_items ON money_transactions.item_id = money_items.item_id JOIN money_catagories ON money_catagories.money_category_id = money_transactions.category_id WHERE money_catagories.money_category_id NOT IN (SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1) AND money_catagories.parent = mc.parent AND money_items.trans_type = -1 AND money_items.family_id = 1 AND money_items.date <= DATE_SUB(CURRENT_DATE(),INTERVAL 1 MONTH)	AND MONTH(money_items.date) = MONTH(DATE_SUB(CURRENT_DATE(),INTERVAL 1 MONTH)) AND YEAR(money_items.date) = YEAR(DATE_SUB(CURRENT_DATE(),INTERVAL 1 MONTH))) / mc2.target_amount)*100) AS percent_last_month,
				(SELECT ROUND(SUM(money_transactions.amount),2) FROM money_transactions JOIN money_items ON money_transactions.item_id = money_items.item_id JOIN money_catagories ON money_catagories.money_category_id = money_transactions.category_id WHERE money_catagories.money_category_id NOT IN (SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1) AND money_catagories.parent = mc.parent AND money_items.trans_type = -1 AND money_items.family_id = 1 AND money_items.date <= DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) AND MONTH(money_items.date) = MONTH(DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR)) AND YEAR(money_items.date) = YEAR(DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR))) AS last_year,
				ROUND(((SELECT ROUND(SUM(money_transactions.amount),2) FROM money_transactions JOIN money_items ON money_transactions.item_id = money_items.item_id JOIN money_catagories ON money_catagories.money_category_id = money_transactions.category_id WHERE money_catagories.money_category_id NOT IN (SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1) AND money_catagories.parent = mc.parent AND money_items.trans_type = -1 AND money_items.family_id = 1 AND money_items.date <= DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR) AND MONTH(money_items.date) = MONTH(DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR)) AND YEAR(money_items.date) = YEAR(DATE_SUB(CURRENT_DATE(),INTERVAL 1 YEAR))) / mc2.target_amount)*100) AS percent_last_year
			FROM money_transactions AS mt
			JOIN money_items AS mi
				ON mt.item_id = mi.item_id
			JOIN money_catagories AS mc
				ON mc.money_category_id = mt.category_id
			JOIN money_catagories AS mc2
				ON mc2.money_category_id = mc.parent
			WHERE mc.money_category_id NOT IN (SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1)
				AND mi.trans_type = -1
				AND YEAR(mi.date) = YEAR(CURRENT_DATE())
				AND MONTH(mi.date) = MONTH(CURRENT_DATE())
				AND mi.family_id = '.$this->mylogin->user()->family_id.'
				AND mi.deleted = 0
			GROUP BY mc.parent
			ORDER BY mc2.description
		'));
	}
	
	function balance_over_time($account_id=0){
		$balance = 0;
		$start_year = 2012;
		$start_month = 1;
		$start_day = 1;
		$data = array();
		$new_data = array();
		$year_set = array($start_year);
		
		//get total transactions grouped by date ordered by date
		$dataset = $this->load->activeModelReturn('model_money_transactions',array(NULL,NULL,'SELECT ROUND(SUM(mi.trans_type * mt.amount),2) as change_amount, mi.`date` as `date` FROM money_items AS mi JOIN money_transactions AS mt	ON mi.item_id = mt.item_id WHERE '.($account_id!=0 ? 'mi.account_id = '.$account_id.' AND ' :'').' mi.family_id = '.$this->mylogin->user()->family_id.' GROUP BY(mi.`date`) ORDER BY mi.`date`'));
		
		foreach($dataset as $day){
			if(!in_array(date('Y',strtotime($day->date)),$year_set)){ $year_set[] = date('Y',strtotime($day->date));}
			$data[date('Y',strtotime($day->date))][date('m',strtotime($day->date))][date('d',strtotime($day->date))] = $day->change_amount;
		}
		
		foreach($year_set as $year){
			for($m=1;$m<=12;$m++){
				for($d=1;$d<=cal_days_in_month(CAL_GREGORIAN, intval($m), $year);$d++){
					if(!isset($data[$year][str_pad($m,2,"0",STR_PAD_LEFT)][str_pad($d,2,"0",STR_PAD_LEFT)]) && (($year < date('Y')) || ($year==date('Y') && $m<=date('m')))){
						$data[$year][str_pad($m,2,"0",STR_PAD_LEFT)][str_pad($d,2,"0",STR_PAD_LEFT)] = 0;
					}
				}
			}
		}
		
		ksort($data);
		
		foreach($data as $year => $year_data){
			ksort($year_data);
			foreach($year_data as $month => $month_data){
				ksort($month_data);
				foreach($month_data as $day => $amount){
					$balance = $balance+$amount;
					if(date('U',strtotime($year.'-'.$month.'-'.$day.' 23:59:59')) <= date('U',strtotime(date('Y-m-d').' 23:59:59'))){
						$new_data[$year.'-'.$month.'-'.$day] = round($balance,2);
					}
				}
			}
		}
		
		ksort($new_data);
		
		return $new_data;
	}
	
	function day_of_week_distributions($category=0,$start_date='',$end_date=''){
		$sql = 'SELECT
							DAYNAME(mi.date) AS day_of_week,
							DAYOFWEEK(mi.date) AS day_of_week_no,
							COUNT(*) AS tran_count,
							ROUND(AVG(mt.amount)) AS tran_avg,
							ROUND(MIN(mt.amount)) AS tran_min,
							ROUND(MAX(mt.amount)) AS tran_max,
							ROUND(SUM(mt.amount)) AS tran_sum
						FROM money_transactions AS mt
						JOIN money_items AS mi
							ON mt.item_id = mi.item_id
						WHERE mi.trans_type = -1
							AND mi.family_id = '.$this->mylogin->user()->family_id.'
							'.($category!=0 ? 'AND mt.category_id = '.$category : '').'
							AND mt.category_id NOT IN(SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1 AND family_id = '.$this->mylogin->user()->family_id.')
							'.($start_date!='' ? 'AND mi.date >= \''.$start_date.'\'' : '').'
							'.($end_date!='' ? 'AND mi.date <= \''.$end_date.'\'' : '').'
						GROUP BY DAYNAME(mi.date)
						ORDER BY DAYOFWEEK(mi.date)';
		$dataset = $this->load->activeModelReturn('model_money_transactions',array(NULL,NULL,$sql));
		
		foreach($dataset as $line){
			$days[$line->day_of_week_no] = array(
				'day' => $line->day_of_week,
				'tran_count' => $line->tran_count,
				'tran_avg' => $line->tran_avg,
				'tran_min' => $line->tran_min,
				'tran_max' => $line->tran_max,
				'tran_sum' => $line->tran_sum
			);
		}
		
		$days_of_week = array(1 => 'Sunday',2 => 'Monday',3 => 'Tuesday',4 => 'Wednesday',5 => 'Thursday',6 => 'Friday',7 => 'Saturday');
		
		foreach($days_of_week as $i => $name){
			if(!isset($days[$i])){
				$days[$i] = array(
					'day' => $name,
					'tran_count' => 0,
					'tran_avg' => 0,
					'tran_min' => 0,
					'tran_max' => 0,
					'tran_sum' => 0
				);
			}
		}
		
		ksort($days);
		
		return $days;
	}
	
	function month_of_year_distributions($category=0,$start_date='',$end_date=''){
		$sql = 'SELECT
							MONTH(mi.date) AS month_no,
							COUNT(*) AS tran_count,
							ROUND(AVG(mt.amount)) AS tran_avg,
							ROUND(MIN(mt.amount)) AS tran_min,
							ROUND(MAX(mt.amount)) AS tran_max,
							ROUND(SUM(mt.amount)) AS tran_sum
						FROM money_transactions AS mt
						JOIN money_items AS mi
							ON mt.item_id = mi.item_id
						WHERE mi.trans_type = -1
							AND mi.family_id = '.$this->mylogin->user()->family_id.'
							'.($category!=0 ? 'AND mt.category_id = '.$category : '').'
							AND mt.category_id NOT IN(SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1 AND family_id = '.$this->mylogin->user()->family_id.')
							'.($start_date!='' ? 'AND mi.date >= \''.$start_date.'\'' : '').'
							'.($end_date!='' ? 'AND mi.date <= \''.$end_date.'\'' : '').'
						GROUP BY MONTH(mi.date)
						ORDER BY MONTH(mi.date)';
		$dataset = $this->load->activeModelReturn('model_money_transactions',array(NULL,NULL,$sql));
		
		foreach($dataset as $line){
			$months[$line->month_no] = array(
				'tran_count' => $line->tran_count,
				'tran_avg' => $line->tran_avg,
				'tran_min' => $line->tran_min,
				'tran_max' => $line->tran_max,
				'tran_sum' => $line->tran_sum
			);
		}
		
		$months_of_year = array(1 => 'Jan',2 => 'Feb',3 => 'Mar',4 => 'Apr',5 => 'May',6 => 'Jun',7 => 'Jul',8 => 'Aug',9 => 'Sep',10 => 'Oct',11 => 'Nov',12 => 'Dec');
		
		foreach($months_of_year as $i => $name){
			if(!isset($months[$i])){
				$months[$i] = array(
					'tran_count' => 0,
					'tran_avg' => 0,
					'tran_min' => 0,
					'tran_max' => 0,
					'tran_sum' => 0
				);
			}
		}
		
		ksort($months);
		
		return $months;
	}
	
	function numeric_distributions($type='day_of_month',$category=0,$start_date='',$end_date=''){
		
		$start = ($type=='day_of_month' ? 1 : 0);
		$end = ($type=='day_of_month' ? 31 : 53);
		$name = ($type=='day_of_month' ? 'Day of Month Breakdown' : 'Week of Year Breakdown');
		
		$sql = 'SELECT
							'.($type=='day_of_month' ? 'DAY(mi.date)' : 'WEEKOFYEAR(mi.date)').' AS counter_no,
							COUNT(*) AS tran_count,
							ROUND(AVG(mt.amount)) AS tran_avg,
							ROUND(MIN(mt.amount)) AS tran_min,
							ROUND(MAX(mt.amount)) AS tran_max,
							ROUND(SUM(mt.amount)) AS tran_sum
						FROM money_transactions AS mt
						JOIN money_items AS mi
							ON mt.item_id = mi.item_id
						WHERE mi.trans_type = -1
							AND mi.family_id = '.$this->mylogin->user()->family_id.'
							'.($category!=0 ? 'AND mt.category_id = '.$category : '').'
							AND mt.category_id NOT IN(SELECT money_category_id FROM money_catagories WHERE dont_include_in_stats = 1 AND family_id = '.$this->mylogin->user()->family_id.')
							'.($start_date!='' ? 'AND mi.date >= \''.$start_date.'\'' : '').'
							'.($end_date!='' ? 'AND mi.date <= \''.$end_date.'\'' : '').'
						GROUP BY '.($type=='day_of_month' ? 'DAY' : 'WEEKOFYEAR').'(mi.date)
						ORDER BY '.($type=='day_of_month' ? 'DAY' : 'WEEKOFYEAR').'(mi.date)';
		$dataset = $this->load->activeModelReturn('model_money_transactions',array(NULL,NULL,$sql));

		foreach($dataset as $line){
			$return_data[$line->counter_no] = array(
				'tran_count' => $line->tran_count,
				'tran_avg' => $line->tran_avg,
				'tran_min' => $line->tran_min,
				'tran_max' => $line->tran_max,
				'tran_sum' => $line->tran_sum
			);
		}
		
		for($i=$start;$i<=$end;$i++){
			if(!isset($return_data[$i])){
				$return_data[$i] = array(
					'tran_count' => 0,
					'tran_avg' => 0,
					'tran_min' => 0,
					'tran_max' => 0,
					'tran_sum' => 0
				);
			}
		}
		
		ksort($return_data);
		
		return array('data' => $return_data, 'start' => $start, 'end' => $end, 'name' => $name);
	}
}

?>
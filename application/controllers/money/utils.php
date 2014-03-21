<?php

class Utils extends My_Controller {
	
	var $types = array();
	var $in_csv_not_hp = array();
	var $found_rows = array();
	var $too_many = array();
	var $day_slip = 4;
	var $account_id = 1;
	var $csv_last_date = '2014-01-25';

	function index(){
		//list accounts for import script
		$this->mysmarty->assign('accounts',$this->load->activeModelReturn('model_money_accounts',array(NULL,'WHERE family_id = '.$this->mylogin->user()->family_id.' ORDER BY name ASC')));
		
		$this->json->setData($this->mysmarty->view('money/utils/index.tpl',false,true));
		$this->json->outputData();
	}
	
	function forward_planning(){
		//select outgoing
		foreach($this->db->query('select month,sum(amount) as total from money_targets WHERE date_ended IS NULL GROUP BY month')->result_array() as $month_target){
			$outgoing_array[$month_target['month']] = $month_target['total'];
		}
		
		$this->mysmarty->assign('outgoing',$outgoing_array);
		
		if($this->input->post('date',false)){
			$this->mysmarty->assign('show_result',true);
			
			$cur_month = date('m');
			$cur_year = date('Y');
			
			if($cur_month==12){
				$cur_month==1;
				$cur_year++;
			}else{
				$cur_month++;
			}

			//total income per month
			$total_income[1] = $this->input->post('jan_in',0);
			$total_income[2] = $this->input->post('feb_in',0);
			$total_income[3] = $this->input->post('mar_in',0);
			$total_income[4] = $this->input->post('apr_in',0);
			$total_income[5] = $this->input->post('may_in',0);
			$total_income[6] = $this->input->post('jun_in',0);
			$total_income[7] = $this->input->post('jul_in',0);
			$total_income[8] = $this->input->post('aug_in',0);
			$total_income[9] = $this->input->post('sep_in',0);
			$total_income[10] = $this->input->post('oct_in',0);
			$total_income[11] = $this->input->post('nov_in',0);
			$total_income[12] = $this->input->post('dec_in',0);
			
			$outgoing_array = $this->input->post('out');
			
			$date_diff = date_diff(date_create(), date_create($this->input->post('date',false)));
			
			
			$balance = $this->db->query('SELECT ROUND(SUM(mi.trans_type*mt.amount),2) as balance FROM money_transactions AS mt JOIN money_items AS mi ON mi.item_id = mt.item_id WHERE deleted = 0 AND family_id = '.$this->mylogin->user()->family_id)->row()->balance;
			
			$balance2 = $this->db->query('SELECT IF(SUM(temp.total)>0,\'credit\',\'debit\') AS `type`, SUM(temp.total) AS `type_total` FROM (
				SELECT a.name, ROUND(SUM(mt.amount*mi.trans_type),2) AS total
				FROM money_accounts AS a
				JOIN money_items AS mi
					ON a.account_id = mi.account_id
				JOIN money_transactions AS mt
					ON mi.item_id = mt.item_id
				WHERE mi.deleted = 0
				AND mi.family_id = '.$this->mylogin->user()->family_id.'
				GROUP BY a.account_id
			) AS temp
			GROUP BY temp.total > 0')->result_array();
			
			foreach($balance2 as $line){
				if($line['type']=='debit'){
					$debit = $line['type_total'];
				}else{
					$credit = $line['type_total'];
				}
			}
			
			//$balance = $balance+260+2247;
			
			$months = $date_diff->m + ($date_diff->y*12) -1;
			
			$return_array = array();
			
			for($m=0;$m<=$months;$m++){
				
				$change_amount = ($total_income[$cur_month]-$outgoing_array[$cur_month]);
				
				if((abs($debit) > $change_amount) && $debit!=0){
					$debit = $debit+$change_amount;
					//echo $cur_month.'-1'."\n";
				}else{
					if($debit<0){
						//echo $cur_month.'-2'."\n";
						$change_amount2 = $debit+$change_amount;
						$debit = 0;
						$credit = $credit+$change_amount2;
					}else{
						$credit = $credit+$change_amount;
						//echo $cur_month.'-3'."\n";
					}
				}
				
				$balance = $balance+$change_amount;
				$return_array[] = array(
					'loop'=>$m,
					'date'=>$cur_year.'-'.str_pad($cur_month,2,"0",STR_PAD_LEFT).'-01',
					'in'=>$total_income[$cur_month],
					'out'=>$outgoing_array[$cur_month],
					'balance'=>$balance,
					'credit'=>$credit,
					'debit'=>$debit
				);
				
				if($cur_month==12){
					$cur_month=1;
					$cur_year++;
				}else{
					$cur_month++;
				}
			}
			
			//print_r($return_array);
			
			$this->mysmarty->assign('results',$return_array);
		}
		
		$this->json->setData($this->mysmarty->view('money/utils/forward_planning.tpl',false,true));
		$this->json->outputData();
	}

	function verify(){
		$csv_data = file_get_contents('Statement Download 2014-Feb-25 21-40-25.csv');
		$csv_array = explode("\n",$csv_data);
		
		//"Date","Transaction type","Description","Paid out","Paid in","Balance"
		
		foreach($csv_array as $k => $line){
			if($k > 4 && !empty($line)){
				
				$line_array = explode(",",$line);
				$date = strtotime(str_replace('"','',$line_array[0]));
				$type = str_replace('"','',$line_array[1]);
				$description = str_replace('"','',$line_array[2]);
				$debit = str_replace('£','',str_replace('"','',$line_array[3]));
				$credit = str_replace('£','',str_replace('"','',$line_array[4]));
				$balance = str_replace('£','',str_replace('"','',$line_array[5]));
				
				if(!in_array($type,$this->types)){
					$this->types[] = $type;
				}
				
				//plus and minus the date by a few days
				$start_date = date("Y-m-d",strtotime(date("Y-m-d",$date) . ' -'.$this->day_slip.' day'));
				$end_date = date("Y-m-d",strtotime(date("Y-m-d",$date) . ' +'.$this->day_slip.' day'));
				
				if($debit!=''){
					
					$search = $this->db->query('SELECT * FROM v_money_transactions WHERE deleted = 0 AND `date` BETWEEN "'.$start_date.'" AND "'.$end_date.'" AND trans_type = -1 AND account_id = '.$this->account_id.' AND amount = "'.$debit.'" AND confirmed = 0');
					
					if($search->num_rows()==1){
						$search = $search->row_array();
						$this->db->query('UPDATE money_items SET confirmed = 1, bank_date = "'.date("Y-m-d",$date).'" WHERE item_id = '.$search['item_id'].' AND confirmed = 0');
						$this->found_rows[] = $search['item_id'];
					}elseif($search->num_rows()==0){
						$this->in_csv_not_hp[] = $line_array;
					}else{
						$this->too_many[] = $search->result_array();
					}
				}elseif($credit!=''){

					$search = $this->db->query('SELECT * FROM v_money_transactions WHERE deleted = 0 AND `date` BETWEEN "'.$start_date.'" AND "'.$end_date.'" AND trans_type = 1 AND account_id = '.$this->account_id.' AND amount = "'.$credit.'" AND confirmed = 0');
					
					if($search->num_rows()==1){
						$search = $search->row_array();
						$this->db->query('UPDATE money_items SET confirmed = 1, bank_date = "'.date("Y-m-d",$date).'" WHERE item_id = '.$search['item_id'].' AND confirmed = 0');
						
						$this->found_rows[] = $search['item_id'];
					}elseif($search->num_rows()==0){
						$this->in_csv_not_hp[] = $line_array;
					}else{
						$this->too_many[] = $search->result_array();
					}
				}
			}
		}
		
		if(count($this->found_rows) > 0){
			$in_hp = $this->db->query('SELECT * FROM v_money_transactions WHERE account_id = 1 AND item_id NOT IN('.implode(',',$this->found_rows).') AND `date` > "'.$this->csv_last_date.'"');
			$in_hp = $in_hp->result_array();
		}else{
			$in_hp = array();
		}
		
		
		echo '<pre>';
		echo 'In HP but not the account'."\n\n";
		print_r($in_hp);
		/*echo 'Items found in both'."\n\n";
		print_r($this->found_rows);*/
		echo 'In account but not in HP'."\n\n";
		print_r($this->in_csv_not_hp);
		echo 'Unsure of search results'."\n\n";
		print_r($this->too_many);
		echo '</pre>';
	}
}

?>
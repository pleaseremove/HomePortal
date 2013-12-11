<?php

class Statistics extends My_Controller {

	function index(){
		$this->mysmarty->assign('cur_month',date('n'));
		$this->mysmarty->assign('cur_year',date('Y'));
		$this->json->setData($this->mysmarty->view('money/statistics/index',false,true));
		$this->json->outputData();
	}
	
	function account_breakdown(){
		$this->mysmarty->assign('accounts',$this->load->activeModelReturn('model_money_accounts',array(NULL,'ORDER BY name ASC')));
		$this->json->setData($this->mysmarty->view('money/statistics/account_stats',false,true));
		$this->json->outputData();
	}
	
	function category_spending(){
		$this->mysmarty->assign('years',$this->load->activeModelReturn('model_money_items',array(NULL,NULL,'SELECT YEAR(date) as `year` FROM money_items GROUP BY YEAR(date) ORDER BY YEAR(date)')));
		$this->mysmarty->assign('cur_year',$this->input->post('year',date('Y')));
		
		$this->mysmarty->assign('table_data',$this->load->activeModelReturn('model_money_catagories',array(NULL,NULL,'SELECT
			mc.description AS "category",
			ROUND(SUM(IF(MONTH(mi.date)=1,mt.amount,0)),2) AS "jan",
			ROUND(SUM(IF(MONTH(mi.date)=2,mt.amount,0)),2) AS "feb",
			ROUND(SUM(IF(MONTH(mi.date)=3,mt.amount,0)),2) AS "mar",
			ROUND(SUM(IF(MONTH(mi.date)=4,mt.amount,0)),2) AS "apr",
			ROUND(SUM(IF(MONTH(mi.date)=5,mt.amount,0)),2) AS "may",
			ROUND(SUM(IF(MONTH(mi.date)=6,mt.amount,0)),2) AS "jun",
			ROUND(SUM(IF(MONTH(mi.date)=7,mt.amount,0)),2) AS "jul",
			ROUND(SUM(IF(MONTH(mi.date)=8,mt.amount,0)),2) AS "aug",
			ROUND(SUM(IF(MONTH(mi.date)=9,mt.amount,0)),2) AS "sep",
			ROUND(SUM(IF(MONTH(mi.date)=10,mt.amount,0)),2) AS "oct",
			ROUND(SUM(IF(MONTH(mi.date)=11,mt.amount,0)),2) AS "nov",
			ROUND(SUM(IF(MONTH(mi.date)=12,mt.amount,0)),2) AS "dec"
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
			AND YEAR(mi.date) = '.$this->input->post('year',date('Y')).'
		GROUP BY mc.money_category_id
		ORDER BY mc.description')));
		
		
		$this->json->setData($this->mysmarty->view('money/statistics/category_spending',false,true));
		$this->json->outputData();
	}
}

?>
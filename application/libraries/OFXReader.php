<?php

class OFXReader {
	
	private $error_message = '';
	private $account_details = array();
	private $transactions = array();
	
	/* Public methods */

	public function load($input_xml=false){
		if(isset($input_xml)){
			$this->parse($input_xml);
		}
	}
	
	public function get_transactions(){
		return $this->transactions;
	}
	
	public function get_error(){
		return $this->error_message;
	}
	
	/* Private methods */
	
	private function parse($input){
	
		if(is_file($input)){
			$ofx = simplexml_load_file($input);
		}else{
			$ofx = simplexml_load_string($input);
		}
		
		if($ofx===false){
			$this->set_error('Failed to parse OFX');
		}
		
		if(isset($ofx->BANKMSGSRSV1->STMTTRNRS->STMTRS)){
			$account = $ofx->BANKMSGSRSV1->STMTTRNRS->STMTRS;
			
			$this->account_details = array(
				'bankId' => $account->BANKACCTFROM->BANKID,
				'AccountId' => $account->BANKACCTFROM->ACCTID,
				'AccountType' => $account->BANKACCTFROM->ACCTTYPE
			);
			
			foreach($account->BANKTRANLIST->STMTTRN as $trans_item){
				$this->parse_single_transaction($trans_item);
			}
						
		}else{
			$this->set_error('No account in the file');
		}
	}
	
	private function parse_single_transaction($tran){
		$this->transactions[] = array(
			'id' => $tran->FITID,
			'description' => $tran->NAME,
			'type' => $tran->TRNTYPE,
			'amount' => $tran->TRNAMT,
			'date_format' => $tran->DTPOSTED,
			'date' => strtotime($tran->DTPOSTED)
		);
	}
	
	private function set_error($message){
		$this->error_message = $message;
		return false;
	}
}
<?PHP

function SQLStringDateTimeToDate($SQLsvrDateAsString){
	if (empty($SQLsvrDateAsString) || $SQLsvrDateAsString == NULL || $SQLsvrDateAsString == '1970-01-01 00:00:00.000'){
		return false;	
	}
	
	list($date,$time) = explode(' ',$SQLsvrDateAsString);
	
	list($year,$month,$day) = explode('-',$date);
	
	list($hour,$minute,$second) = explode(':',$time);
	
	list($second,$splitsecond) = explode('.',$second);
	
	return mktime($hour,$minute,$second,$month,$day,$year);
}

function UKDateStringToSQLDateString($UKDateString = NULL){
	//Expects something like dd/mm/yyyy
	
	if (!isset($UKDateString) || empty($UKDateString)){
		return NULL;	
	}
	
	$dateParts = explode('/',trim($UKDateString));
	
	if (count($dateParts) != 3){
		return NULL;
	}
	
	return $dateParts[2].'-'.$dateParts[1].'-'.$dateParts[0];
	
}

function SQLServerNow(){
	return date('Y-m-d H:i:s.000');//2012-05-30 00:00:00.000
}

?>
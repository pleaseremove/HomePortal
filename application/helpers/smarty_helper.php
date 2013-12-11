<?PHP
function getDateFromSmartyDate($prefix,$valIfNull=''){
	$year = isset($_REQUEST[$prefix.'Year']) ? $_REQUEST[$prefix.'Year'] : false;;
	$month = isset($_REQUEST[$prefix.'Month']) ? $_REQUEST[$prefix.'Month'] : false;
	$day = isset($_REQUEST[$prefix.'Day']) ? $_REQUEST[$prefix.'Day'] : false;
	
	if(!$year || !$month || !$day){
		return $valIfNull;
	}
	
	return mktime(0,0,0,$month,$day,$year);
}

?>
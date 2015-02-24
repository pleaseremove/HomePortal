var $last_one = null;

$('.widget').each(function(){
	if($(this).hasClass('full')){
		$last_one = null;
	}else{
		if($last_one!=null){
			var new_height = ($(this).find('.widget_content:first').height()>$last_one.find('.widget_content:first').height() ? $(this).find('.widget_content:first').height() : $last_one.find('.widget_content:first').height());
			$(this).find('.widget_content:first').height(new_height);
			$last_one.find('.widget_content:first').height(new_height);
			$last_one = null;
		}else{
			$last_one = $(this);
		}
	}
});
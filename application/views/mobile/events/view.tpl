<form method="post" action="/mobile/events/save">
		<div data-role="fieldcontain">
			<label for="title">Name:</label>
			<input type="text" name="title" id="title" value="{$ci->event->title}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="description">Description:</label>
			<textarea name="details" id="description">{$ci->event->description}</textarea>
		</div>
		
		<div data-role="fieldcontain">
			<label for="start_date">Start Date:</label>
			<input type="date" name="start_date" id="start_date" value="{$ci->event->start_date}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="end_date">End Date:</label>
			<input type="date" name="end_date" id="end_date" value="{$ci->event->end_date}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="all_day" class="select">All Day:</label>
			<select name="all_day" id="all_day">
				<option value="0" {if isset($ci->event->all_day) && $ci->event->all_day==0} selected="selected"{/if}>No</option>
				<option value="1" {if isset($ci->event->all_day) && $ci->event->all_day==1} selected="selected"{/if}>Yes</option>
			</select>
		</div>
		
		<div data-role="fieldcontain">
			<label for="start_time">Start Time:</label>
			<input type="time" name="start_time" id="start_time" value="{$ci->event->start_time}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="end_time">End Time:</label>
			<input type="time" name="end_time" id="end_time" value="{$ci->event->end_time}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="important" class="select">Important:</label>
			<select name="important" id="important">
				<option value="0" {if isset($ci->event->important) && $ci->event->important==0} selected="selected"{/if}>No</option>
				<option value="1" {if isset($ci->event->important) && $ci->event->important==1} selected="selected"{/if}>Yes</option>
			</select>
		</div>
		
		<div data-role="fieldcontain">
			<label for="private" class="select">Private:</label>
			<select name="private" id="private">
				<option value="0" {if isset($ci->event->private) && $ci->event->private==0} selected="selected"{/if}>No</option>
				<option value="1" {if isset($ci->event->private) && $ci->event->private==1} selected="selected"{/if}>Yes</option>
			</select>
		</div>
		
		<input type="hidden" value="{$ci->event->id()}" name="event_id" />
		<input type="submit" value="Save" />
	</form>
</div>

<script type="text/javascript">
	$(function(){
		
		$('select[name=all_day]').bind('change',function(){
			if($(this).val()==1){
				$('input[name=start_time]').parent().parent().hide();
				$('input[name=end_time]').parent().parent().hide();
			}else{
				$('input[name=start_time]').parent().parent().show();
				$('input[name=end_time]').parent().parent().show();
			}
		});
		
		$('input[name=start_date]').bind('blur',function(){
			$('input[name=end_date]').val($(this).val());
		});
		
		$('input[name=start_time]').bind('blur',function(){
			$('input[name=end_time]').val($(this).val());
		});
		
		if($('select[name=all_day]').val()==1){
			$('input[name=start_time]').parent().parent().hide();
			$('input[name=end_time]').parent().parent().hide();
		}else{
			$('input[name=start_time]').parent().parent().show();
			$('input[name=end_time]').parent().parent().show();
		}
	});
</script>
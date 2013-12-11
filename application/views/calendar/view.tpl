<form action="calendar/save">
	<div class="form_100"><label>Title</label><input type="text" name="title" value="{$event->title}"></div>
	<div class="form_100"><label>Location</label><input type="text" name="location" value="{$event->location}"></div>
	<div class="form_30"><label>Start Date</label><input type="text" name="start_date" value="{$event->start_date}" class="date_picker"></div>
	<div class="form_30"><label>Start Time</label><input type="text" name="start_time" value="{$event->start_time|date_format:'%H:%M'}" class="time_picker"></div>
	<div class="form_30">
		<label>All Day</label>
		<select name="all_day">
			<option value="0" {if isset($event->all_day) && $event->all_day==0} selected="selected"{/if}>No</option>
			<option value="1" {if isset($event->all_day) && $event->all_day==1} selected="selected"{/if}>Yes</option>
		</select>
	</div>
	<div class="form_30"><label>End Date</label><input type="text" name="end_date" value="{$event->end_date}" class="date_picker"></div>
	<div class="form_30"><label>End Time</label><input type="text" name="end_time" value="{$event->end_time|date_format:'%H:%M'}" class="time_picker"></div>
	<div class="form_30">
		<label>Repeat</label>
		<button name="repeat" style="cursor:pointer">Update Settings</button>
	</div>
	<div class="form_100">
		<textarea style="height:182px;margin-top:10px;" name="description">{$event->description}</textarea>
	</div>
	
	<div class="form_30">
		<label>Private</label>
		<select name="private">
			<option value="0" {if isset($event->private) && $event->private==0} selected="selected"{/if}>No</option>
			<option value="1" {if isset($event->private) && $event->private==1} selected="selected"{/if}>Yes</option>
		</select>
	</div>
	
	<div class="form_30">
		<label>Important</label>
		<select name="important">
			<option value="0" {if isset($event->important) && $event->important==0} selected="selected"{/if}>No</option>
			<option value="1" {if isset($event->important) && $event->important==1} selected="selected"{/if}>Yes</option>
		</select>
	</div>
	
	{if !$event->isNew()}
	<div class="form_30">
		<label>Delete?</label>
		<input name="delete" type="checkbox" value="1" />
	</div>
	{/if}
	<input type="hidden" name="event_id" value="{$event->id()|default:'0'}">
	
	<div id="repeat_box" style="display:none">
		
		<div class="form_50">
			<label>How Often</label>
			<select name="repeat_regularity">
				<option value="0" {if isset($event->repeat) && $event->repeat==0} selected="selected"{/if}>None</option>
				<option value="1" {if isset($event->repeat) && $event->repeat==1} selected="selected"{/if}>Weekly</option>
				<option value="2" {if isset($event->repeat) && $event->repeat==2} selected="selected"{/if}>Bi-Weekly</option>
				<option value="3" {if isset($event->repeat) && $event->repeat==3} selected="selected"{/if}>Monthly</option>
				<option value="4" {if isset($event->repeat) && $event->repeat==4} selected="selected"{/if}>Yearly</option>
			</select>
		</div>
	
		<div class="form_50">
			<label>Type</label>
			<select name="repeat_type">
				<option value="0">By Day</option>
				<option value="1">By Date</option>
			</select>
		</div>
		
		<div class="form_50"><label>Repeat Start</label><input type="text" name="repeat_start" value="" class="date_picker"></div>
		<div class="form_50"><label>Repeat End</label><input type="text" name="repeat_end" value="" class="date_picker"></div>
	</div>
</form>
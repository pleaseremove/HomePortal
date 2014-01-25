<form action="calendar/save">
	<div class="tabs_box">
	
		<ul>
			<li class="c-main active" data-tab="c-main">Main Details</li>
			<li class="c-additional" data-tab="c-additional">Additional Details</li>
			<li class="c-repeat" data-tab="c-repeat">Repeat Informtation</li>
			<li class="c-alarms" data-tab="c-alarms">Alarms</li>
		</ul>
		
		<div class="tab c-main">
			
			<div class="form_100"><label>Title</label><input type="text" name="title" value="{$event->title}"></div>
			
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
				<label>Important</label>
				<select name="important">
					<option value="0" {if isset($event->important) && $event->important==0} selected="selected"{/if}>No</option>
					<option value="1" {if isset($event->important) && $event->important==1} selected="selected"{/if}>Yes</option>
				</select>
			</div>
			
			<div class="form_100">
				<textarea style="height:182px;margin-top:10px;" name="description">{$event->description}</textarea>
			</div>
			
		</div>
		
		<div class="tab c-additional">
		
			<div class="form_100"><label>Location</label><input type="text" name="location" value="{$event->location}"></div>
			
			<div class="form_50">
				<label>Private</label>
				<select name="private">
					<option value="0" {if isset($event->private) && $event->private==0} selected="selected"{/if}>No</option>
					<option value="1" {if isset($event->private) && $event->private==1} selected="selected"{/if}>Yes</option>
				</select>
			</div>
			
			<div class="form_50">
				<label>Tentative</label>
				<select name="tentative">
					<option value="0" {if isset($event->tentative) && $event->tentative==0} selected="selected"{/if}>No</option>
					<option value="1" {if isset($event->tentative) && $event->tentative==1} selected="selected"{/if}>Yes</option>
				</select>
			</div>
			
			
			{if !$event->isNew()}
			<div class="form_50">
				<label>Delete?</label>
				<input name="delete" type="checkbox" value="1" />
			</div>
			{/if}
			
		</div>
		
		<div class="tab c-repeat">
			<p>Repeat Data (not functional)
		</div>
		
		<div class="tab c-alarms">
			<p>Alarms</p>
		</div>
		
		<input type="hidden" name="event_id" value="{$event->id()|default:'0'}">
	</div>
</form>
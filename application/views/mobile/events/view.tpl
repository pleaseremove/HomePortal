<form method="post" action="/mobile/events/save">
		<div data-role="fieldcontain">
			<label for="title">Name:</label>
			<input type="text" name="name" id="title" value="{$ci->event->title}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="description">Description:</label>
			<textarea name="details" id="description">{$ci->event->description}</textarea>
		</div>
		
		<div data-role="fieldcontain">
			<label for="start_date">Start Date:</label>
			<input type="text" name="start_date" id="title" value="{$ci->event->start_date}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="end_date">End Date:</label>
			<input type="text" name="end_date" id="title" value="{$ci->event->end_date}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="all_day" class="select">All Day:</label>
			<select name="all_day" id="all_day">
				<option value="0" {if isset($ci->event->all_day) && $ci->event->all_day==0} selected="selected"{/if}>No</option>
				<option value="1" {if isset($ci->event->all_day) && $ci->event->all_day==1} selected="selected"{/if}>Yes</option>
			</select>
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
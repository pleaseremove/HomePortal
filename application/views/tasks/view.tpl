<form action="tasks/save">
	<div class="form_100"><label>Name</label><input type="text" name="name" value="{$task->name}"></div>

	<div class="form_30"><label>Due Date</label><input type="text" name="date_due" value="{$task->date_due}" class="date_picker"></div>
	<div class="form_30">
		<label>Private</label>
		<select name="private">
			<option value="0" {if isset($task->private) && $task->private==0} selected="selected"{/if}>No</option>
			<option value="1" {if isset($task->private) && $task->private==1} selected="selected"{/if}>Yes</option>
		</select>
	</div>
	<div class="form_30">
		<label>Priority</label>
		<select name="priority">
			<option value="1" {if isset($task->priority) && $task->priority==1} selected="selected"{/if}>Very Low</option>
			<option value="2" {if isset($task->priority) && $task->priority==2} selected="selected"{/if}>Low</option>
			<option value="3" {if isset($task->priority) && $task->priority==3} selected="selected"{/if}>Normal</option>
			<option value="4" {if isset($task->priority) && $task->priority==4} selected="selected"{/if}>High</option>
			<option value="5" {if isset($task->priority) && $task->priority==5} selected="selected"{/if}>Very High</option>
		</select>
	</div>
	
	<div class="form_100">
		<textarea style="height:230px;margin-top:10px;" name="details">{$task->details}</textarea>
	</div>
	
	<div class="form_30">
		<label>Complete</label>
		<select name="completed">
			<option value="0" {if isset($task->completed) && $task->completed==0} selected="selected"{/if}>No</option>
			<option value="1" {if isset($task->completed) && $task->completed==1} selected="selected"{/if}>Yes</option>
		</select>
	</div>
	<input type="hidden" name="task_id" value="{$task->id()|default:'0'}">
</form>
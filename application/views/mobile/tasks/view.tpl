<form method="post" action="/mobile/tasks/save">
		<div data-role="fieldcontain">
			<label for="name">Name:</label>
			<input type="text" name="name" id="name" value="{$task->name}" />
		</div>
		<div data-role="fieldcontain">
			<label for="priority" class="select">Priority:</label>
			<select name="priority" id="priority">
				<option value="0" {if isset($task->priority) && $task->priority==1} selected="selected"{/if}>Very Low</option>
				<option value="1" {if isset($task->priority) && $task->priority==2} selected="selected"{/if}>Low</option>
				<option value="2" {if isset($task->priority) && $task->priority==3} selected="selected"{/if}>Normal</option>
				<option value="3" {if isset($task->priority) && $task->priority==4} selected="selected"{/if}>High</option>
				<option value="4" {if isset($task->priority) && $task->priority==5} selected="selected"{/if}>Very High</option>
			</select>
		</div>
		<div data-role="fieldcontain">
			<label for="name">Description:</label>
			<textarea name="details" id="details">{$task->details}</textarea>
		</div>
		<input type="hidden" value="{$task->id()}" name="task_id" />
		<input type="submit" value="Save" />
	</form>
</div>
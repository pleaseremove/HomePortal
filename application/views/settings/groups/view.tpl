<form action="settings/groups/save">

	<div class="form_100"><label>Description</label><input type="text" name="description" value="{$group->description}"></div>
	
	<input type="hidden" name="group_id" value="{$group->id()|default:'0'}">
	
</form>
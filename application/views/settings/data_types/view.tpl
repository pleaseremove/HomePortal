<form action="settings/data_types/save">

	<div class="form_50"><label>Name</label><input type="text" name="data_type_name" value="{$type->data_type_name}"></div>
	<div class="form_50"><label>Pattern</label><input type="text" name="data_type_view_string" value='{$type->data_type_view_string|default:'<%data%>'}'></div>
	
	<input type="hidden" name="type_id" value="{$type->id()|default:'0'}">
	
</form>
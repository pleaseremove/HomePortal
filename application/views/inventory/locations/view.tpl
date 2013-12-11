<form action="inventory/locations/save">
	<div class="form_100"><label>Name</label><input type="text" name="location_name" value="{$location->location_name}"></div>
	
	<div class="form_100">
		<label>Location</label>
		<textarea name="location_description">{$location->location_description}</textarea>
	</div>

	<input type="hidden" name="location_id" value="{$location->id()|default:'0'}">
</form>
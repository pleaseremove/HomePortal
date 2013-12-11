<form action="inventory/containers/save">
	<div class="form_100"><label>Name</label><input type="text" name="container_name" value="{$container->container_name}"></div>
	
	<div class="form_50">
		<label>Location</label>
		<select name="location_id">
			{foreach from=$locations item=l}
				<option value="{$l->location_id}" {if isset($container->location_id) && $container->location_id==$l->location_id} selected="selected"{/if}>{$l->location_name}</option>
			{/foreach}
		</select>
	</div>
	
	<div class="form_50">
		<label>Type</label>
		<select name="container_type">
			<option value="card_box" {if isset($container->container_type) && $container->container_type=='card_box'} selected="selected"{/if}>Card Box</option>
			<option value="plastic_box" {if isset($container->container_type) && $container->container_type=='plastic_box'} selected="selected"{/if}>Plastic Box</option>
			<option value="open_space" {if isset($container->container_type) && $container->container_type=='open_space'} selected="selected"{/if}>Open Box</option>
		</select>
	</div>

	<input type="hidden" name="container_id" value="{$container->id()|default:'0'}">
</form>
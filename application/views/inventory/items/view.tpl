<form action="inventory/items/save">
	<div class="form_100"><label>Name</label><input type="text" name="name" value="{$item->name}"></div>

	<div class="form_30"><label>Cost (&pound;)</label><input type="text" name="bought_for" value="{$item->bought_for}"></div>
	<div class="form_30"><label>Value (&pound;)</label><input type="text" name="current_value" value="{$item->current_value}"></div>
	<div class="form_30">
		<label>Container</label>
		<select name="container_id">
			{foreach from=$containers item=l name=loc_loop}
				{if $smarty.foreach.loc_loop.first}<optgroup label="{$l->location}">{/if}
				
				<option value="{$l->container_id}" {if isset($item->container_id) && $item->container_id==$l->container_id} selected="selected"{/if}>{$l->container}</option>
				
				{if $l->location!=$last_location && !$smarty.foreach.loc_loop.last && !$smarty.foreach.loc_loop.first}
					</optgroup>
  				<optgroup label="{$l->location}">
  			{/if}
				
				{assign var=last_location value=$l->location}
				{if $smarty.foreach.loc_loop.last}</optgroup>{/if}
			{/foreach}
		</select>
	</div>
	
	<div class="form_100">
		<textarea style="height:230px;margin-top:10px;" name="description">{$item->description}</textarea>
	</div>
	
	<div class="form_30"><label>Quantity</label><input type="text" name="quantity" value="{$item->quantity|default:'1'}"></div>

	<input type="hidden" name="invent_id" value="{$item->id()|default:'0'}">
</form>
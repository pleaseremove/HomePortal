{foreach from=$locations item=l}
	<tr data-click="inventory/locations/view/{$l->id()}" data-selection="inventory-locations" data-height="230" data-menu-click="inventory-locations" data-title="{$l->location_name|capitalize}" class="model">
		<td>{$l->location_name}</td>
		<td>{$l->location_description}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="2">No Locations Found</td>
	</tr>
{/foreach}
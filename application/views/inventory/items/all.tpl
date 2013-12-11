{foreach from=$items item=i}
	<tr data-click="inventory/items/view/{$i->id()}" data-menu-click="inventory-items" data-title="{$i->name|capitalize}" data-selection="inventory-items" class="model">
		<td>{$i->name}</td>
		<td>&pound;{$i->bought_for|number_format:2:'.':','}</td>
		<td>&pound;{$i->current_value|number_format:2:'.':','}</td>
		<td>{$i->container()->container_name}</td>
		<td>{$i->container()->location()->location_name}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="5">No Items Found</td>
	</tr>
{/foreach}
{foreach from=$containers item=c}
	<tr data-click="inventory/containers/view/{$c->id()}" data-title="{$c->container_name}" data-height="200" data-selection="inventory-containers" class="model">
		<td>{$c->container_name}</td>
		<td>{$c->container_type|replace:'_':' '|capitalize}</td>
		<td>{$c->location_name}</td>
		<td>{$c->item_count}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="4">No Containers Found</td>
	</tr>
{/foreach}
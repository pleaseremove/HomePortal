{foreach from=$types item=t}
	<tr {if $t->family_id!=0}data-click="settings/data_types/view/{$t->id()}" data-height="150" data-width="600" data-title="{$t->data_type_name|capitalize}" class="model"{/if}>
		<td>{$t->data_type_name|capitalize}</td>
		<td>{$t->data_type_view_string|escape}</td>
		<td>{if $t->family_id!=0}Yes{/if}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="1">No Data Types Found</td>
	</tr>
{/foreach}
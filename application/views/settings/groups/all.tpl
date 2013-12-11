{foreach from=$groups item=g}
	<tr data-click="settings/groups/view/{$g->id()}" data-height="150" data-width="400" data-title="{$g->name|capitalize}" class="model">
		<td>{$g->description|capitalize}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="1">No Groups Found</td>
	</tr>
{/foreach}
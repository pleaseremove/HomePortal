{foreach from=$notes item=n}
	<tr data-click="notes/view/{$n->id()}" data-menu-click="notes" data-title="{$n->name|capitalize}" data-selection="notes" class="model">
		<td>{$n->name|capitalize}</td>
		<td>{$n->date_created|date_format}</td>
		<td>{$n->date_updated|date_format}</td>
		<td>{$n->created_by()->name|capitalize}</td>
		<td>{$n->updated_by()->name|capitalize}</td>
		<td>{if $n->private==1}Yes{/if}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="6">No Notes Found</td>
	</tr>
{/foreach}
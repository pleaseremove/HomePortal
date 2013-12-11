{foreach from=$tasks item=t}
	<tr data-click="tasks/view/{$t->id()}" data-menu-click="tasks" data-title="{$t->name|capitalize}" data-selection="tasks" class="model">
		<td>{$t->name|capitalize}</td>
		<td>{$t->date_created|date_format}</td>
		<td>{$t->date_due|date_format|default:''}</td>
		<td>{if $t->priority==1}Very Low{elseif $t->priority==2}Low{elseif $t->priority==3}Normal{elseif $t->priority==4}High{elseif $t->priority==5}Very High{/if}</td>
		<td>{$t->created_by()->name|capitalize}</td>
		<td>{if $t->completed==1}Yes{/if}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="6">No Tasks Found</td>
	</tr>
{/foreach}
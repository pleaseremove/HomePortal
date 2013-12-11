{foreach from=$transactions item=t}
	<tr data-click="money/transactions/view/{$t->item_id}" data-menu-click="money-all" data-title="{$t->date|date_format} - {$t->account_name}" data-selection="money-all" class="model">
		<td class="{if $t->account_verified==1}{if $t->confirmed==1}ver_confirmed{else}ver_unconfirmed{/if}{else}ver_unknown{/if}"></td>
		<td>{$t->date|date_format}</td>
		<td>&pound;{$t->amount|number_format:2:'.':','}</td>
		<td>{$t->account_name}</td>
		<td style="color:{if $t->trans_type==1}green{elseif $t->trans_type==-1}red{/if}">{if $t->trans_type==1}Credit{elseif $t->trans_type==-1}Debit{/if}</td>
		<td>{$t->top_descriptions}</td>
		<td>{$t->cat_descriptions}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="7">No Transactions Found</td>
	</tr>
{/foreach}
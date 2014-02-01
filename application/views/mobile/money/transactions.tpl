<table>
	<thead>
		<tr>
			<th>Date</th>
			<th>Amount</th>
			<th>Account</th>
			<th>Type</th>
			<th>Category</th>
		</tr>
	</thead>
	<tbody>
		{foreach from=$transactions item=t}
			<tr>
				<td>{$t->date|date_format}</td>
				<td>&pound;{$t->amount|number_format:2:'.':','}</td>
				<td>{$t->account_name}</td>
				<td style="color:{if $t->trans_type==1}green{elseif $t->trans_type==-1}red{/if}">{if $t->trans_type==1}Credit{elseif $t->trans_type==-1}Debit{/if}</td>
				<td>{$t->top_descriptions}</td>
			</tr>
		{foreachelse}
			<tr>
				<td colspan="5">No Transactions Found</td>
			</tr>
		{/foreach}
	</tbody>
</table>
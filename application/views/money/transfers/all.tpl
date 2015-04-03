{foreach from=$transfers item=t}
	<tr>
		<td>{$t->date|date_format}</td>
		<td>{$t->out_account}</td>
		<td>{$t->in_account}</td>
		<td>&pound;{$t->amount|number_format:2:'.':','}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="4">No Transfers Found</td>
	</tr>
{/foreach}
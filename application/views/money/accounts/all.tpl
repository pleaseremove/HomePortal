{foreach from=$accounts item=a}
	<tr data-click="money/accounts/view/{$a->id()}" data-title="{$a->name|capitalize}" data-height="200" data-selection="money-accounts" class="model">
		<td>{$a->name|capitalize}</td>
		<td>{$a->description|capitalize}</td>
		<td>{$a->type}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="3">No Accounts Found</td>
	</tr>
{/foreach}
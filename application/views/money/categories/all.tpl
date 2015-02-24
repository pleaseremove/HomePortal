{foreach from=$categories item=c}
	<tr data-click="money/categories/view/{$c->money_category_id}" data-title="{$c->cat_desc|capitalize}" data-height="200" data-width="500" data-selection="money-categories" class="model">
		<td>{$c->parent_desc|capitalize}</td>
		<td>{$c->cat_desc|capitalize}</td>
		<td>&pound{$c->total_in|number_format:2:".":","}</td>
		<td>&pound{$c->total_out|number_format:2:".":","}</td>
		<td>{$c->trans_count_in}</td>
		<td>{$c->trans_count_out}</td>
		<td>{if $c->parent!=0}<a href="money/categories/stats/{$c->money_category_id}">View</a>{/if}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="6">No Categories Found</td>
	</tr>
{/foreach}
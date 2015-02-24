{foreach from=$categories item=c}
	<tr data-click="settings/parent_categories/view/{$c->money_category_id}" data-title="{$c->description|capitalize}" data-height="200" data-width="500" data-selection="money-categories" class="model">
		<td>{$c->description|capitalize}</td>
		<td>&pound{$c->target_amount}</td>
		<td style="background-color:#{$c->color}"></td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="3">No Categories Found</td>
	</tr>
{/foreach}
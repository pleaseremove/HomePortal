<form method="post" action="/mobile/money/all">
	<fieldset data-role="collapsible" data-mini="true">
		<legend>Filters</legend>
		<div data-role="fieldcontain">
			<label for="account_id" class="select">Account:</label>
			<select name="filter[account_id]" id="account_id">
				<option value="">All</option>
				{foreach from=$accounts item=a}
					<option value="{$a->id()}" {if isset($smarty.post.filter.account_id) && $smarty.post.filter.account_id==$a->id()} selected="selected"{/if}>{$a->name}</option>
				{/foreach}
			</select>
		</div>
		
		<div data-role="fieldcontain">
			<label for="catagory_id" class="select">Category:</label>
			<select name="filter[category_id]" id="category_id">
				<option value="">All</option>
				{foreach from=$categories name=category item=c}
					{if $group != $c->parent}
	           {if !$smarty.foreach.category.first}</optgroup>{/if}
	           {assign var='group' value=$c->parent}
	           <optgroup label="{$group}">
	         {/if}
	         <option label="{$c->description}" value="{$c->id}" {if isset($smarty.post.filter.category_id) && $smarty.post.filter.category_id==$c->id} selected="selected"{/if}>{$c->description}</option>
	         {if $smarty.foreach.category.last}</optgroup>{/if}
				{/foreach}
			</select>
		</div>
		
		<div data-role="fieldcontain">
			<label for="trans_type" class="select">Type:</label>
			<select name="filter[trans_type]" id="trans_type">
				<option value="">All</option>
					<option value="-1" {if isset($smarty.post.filter.trans_type) && $smarty.post.filter.trans_type==-1} selected="selected"{/if}>Debit</option>
					<option value="1" {if isset($smarty.post.filter.trans_type) && $smarty.post.filter.trans_type==1} selected="selected"{/if}>Credit</option>
			</select>
		</div>
		
		<div data-role="fieldcontain">
			<label for="date_start" class="select">Date From:</label>
			<input type="date" name="date_range_s[date]" id="date_start" value="{$smarty.post.date_range_s.date}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="date_end" class="select">Date To:</label>
			<input type="date" name="date_range_e[date]" id="date_end" value="{$smarty.post.date_range_e.date}" />
		</div>
		
		<input type="submit" value="Apply" />
	</fieldset>
</form>
<br />
<table class="table-stroke transaction_list">
	<thead>
		<tr>
			<th>Date</th>
			<th>Amount</th>
			<th>Account</th>
			<th>Categories</th>
		</tr>
	</thead>
	<tbody>
		{foreach from=$transactions item=t}
			<tr>
				<td style="white-space:nowrap">{$t->date|date_format}</td>
				<td style="color:{if $t->trans_type==1}green{elseif $t->trans_type==-1}red{/if}">&pound;{$t->amount|number_format:2:'.':','}</td>
				<td>{$t->account_name}</td>
				<td>{$t->cat_descriptions_without}</td>
			</tr>
		{foreachelse}
			<tr>
				<td colspan="4">No Transactions Found</td>
			</tr>
		{/foreach}
	</tbody>
</table>
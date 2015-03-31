<div id="title_bar" class="box_background border_color_bottom">
	<h2>Statistics: Category {if $type=='debits'}Spending{else}Income{/if}</h2>
</div>

<div id="content">
	
	{if $type=='debits'}
		{include file="money/statistics/tab_bar.tpl" active_tab="cat_debits"}
	{else}
		{include file="money/statistics/tab_bar.tpl" active_tab="cat_credits"}
	{/if}

	<form action="money/statistics/category_aggregate/{$type}">
		<p style="margin: 10px 2%;">
			<label>Year</label>
			<select name="year">
				{foreach from=$years item=y}
					<option value="{$y->year}" {if $y->year==$cur_year}selected="selected"{/if}>{$y->year}</option>
				{/foreach}
			</select>
			<input type="submit" value="Update" />
		</p>
	</form>
	{assign var='total_jan' value=0}
	{assign var='total_feb' value=0}
	{assign var='total_mar' value=0}
	{assign var='total_apr' value=0}
	{assign var='total_may' value=0}
	{assign var='total_jun' value=0}
	{assign var='total_jul' value=0}
	{assign var='total_aug' value=0}
	{assign var='total_sep' value=0}
	{assign var='total_oct' value=0}
	{assign var='total_nov' value=0}
	{assign var='total_dec' value=0}
	{assign var='total_last' value=0}
	{assign var='total_this' value=0}
	
	{assign var='last_cat' value=''}

	<div class="widget full">
		<div class="widget_title">Category {if $type=='debits'}Spending{else}Income{/if} ({$cur_year})</div>
		<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
			<table class="data_grid style_only numbers">
				<thead>
					<tr>
						<th>Category</th>
						<th>Jan</th>
						<th>Feb</th>
						<th>Mar</th>
						<th>Apr</th>
						<th>May</th>
						<th>Jun</th>
						<th>Jul</th>
						<th>Aug</th>
						<th>Sep</th>
						<th>Oct</th>
						<th>Nov</th>
						<th>Dec</th>
						<th>Total {$last_year}</th>
						<th>Total {$cur_year}</th>
					</tr>
				</thead>
				{foreach from=$table_data item=a name=data_loop}
					{if $last_cat!=$a->top_category}
						{assign var='last_cat' value=$a->top_category}
						{if !$smarty.foreach.data_loop.first}
							</tbody>
						{/if}
						<tbody>
							<tr>
								<td colspan="15" style="text-align:left;{if !$smarty.foreach.data_loop.first}border-top:1px solid #DADADA;{/if}border-bottom:1px solid #DADADA;">{$a->top_category}</td>
							</tr>
					{/if}
					
					{assign var='total_jan' value=$total_jan+$a->jan}
					{assign var='total_feb' value=$total_feb+$a->feb}
					{assign var='total_mar' value=$total_mar+$a->mar}
					{assign var='total_apr' value=$total_apr+$a->apr}
					{assign var='total_may' value=$total_may+$a->may}
					{assign var='total_jun' value=$total_jun+$a->jun}
					{assign var='total_jul' value=$total_jul+$a->jul}
					{assign var='total_aug' value=$total_aug+$a->aug}
					{assign var='total_sep' value=$total_sep+$a->sep}
					{assign var='total_oct' value=$total_oct+$a->oct}
					{assign var='total_nov' value=$total_nov+$a->nov}
					{assign var='total_dec' value=$total_dec+$a->dec}
					{assign var='total_last' value=$total_last+$a->total_last}
					{assign var='total_this' value=$total_this+$a->total_this}
					<tr>
						 <td>{$a->category}</td>
						 <td title="Previous Year: {$a->jan1|number_format:2:".":","}">{$a->jan|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->feb1|number_format:2:".":","}">{$a->feb|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->mar1|number_format:2:".":","}">{$a->mar|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->apr1|number_format:2:".":","}">{$a->apr|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->may1|number_format:2:".":","}">{$a->may|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->jun1|number_format:2:".":","}">{$a->jun|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->jul1|number_format:2:".":","}">{$a->jul|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->aug1|number_format:2:".":","}">{$a->aug|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->sep1|number_format:2:".":","}">{$a->sep|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->oct1|number_format:2:".":","}">{$a->oct|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->nov1|number_format:2:".":","}">{$a->nov|number_format:2:".":","}</td>
						 <td title="Previous Year: {$a->dec1|number_format:2:".":","}">{$a->dec|number_format:2:".":","}</td>
						 <td style="color:{if $a->total_last>$a->total_this}red{else}green{/if}">{$a->total_last}</td>
						 <td style="color:{if $a->total_last>$a->total_this}green{else}red{/if}">{$a->total_this}</td>
					</tr>
					
					{if !$smarty.foreach.data_loop.last}
						</tbody>
					{/if}
				{/foreach}
				<tfoot>
					<tr>
						 <td>Totals</td>
						 <td>{$total_jan|number_format:2:".":","}</td>
						 <td>{$total_feb|number_format:2:".":","}</td>
						 <td>{$total_mar|number_format:2:".":","}</td>
						 <td>{$total_apr|number_format:2:".":","}</td>
						 <td>{$total_may|number_format:2:".":","}</td>
						 <td>{$total_jun|number_format:2:".":","}</td>
						 <td>{$total_jul|number_format:2:".":","}</td>
						 <td>{$total_aug|number_format:2:".":","}</td>
						 <td>{$total_sep|number_format:2:".":","}</td>
						 <td>{$total_oct|number_format:2:".":","}</td>
						 <td>{$total_nov|number_format:2:".":","}</td>
						 <td>{$total_dec|number_format:2:".":","}</td>
						 <td style="color:{if $type=='debits'}{if $total_last>$total_this || $total_last!=$total_this}red{else}green{/if}{else}{if $total_last<$total_this || $total_last==$total_this}green{else}red{/if}{/if}">{$total_last}</td>
						 <td style="color:{if $type=='debits'}{if $total_last>$total_this || $total_last==$total_this}green{else}red{/if}{else}{if $total_last<$total_this || $total_last!=$total_this}red{else}green{/if}{/if}">{$total_this}</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
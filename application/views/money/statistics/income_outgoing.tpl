<div id="title_bar" class="box_background border_color_bottom">
	<h2>Statistics: Income / Outgoings</h2>
</div>

<div id="content">
	
	{include file="money/statistics/tab_bar.tpl" active_tab="income_outgoing"}
	
	{assign var='total_income' value=0}
	{assign var='total_outgoing' value=0}
	{assign var='total_profit' value=0}

	<div class="widget full">
		<div class="widget_title">Income / Outgoings</div>
		<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
			<table class="data_grid style_only numbers">
				<thead>
					<tr>
						<th>Year</th>
						<th>Income</th>
						<th>Outgoings</th>
						<th>Profit</th>
					</tr>
				</thead>
				<tbody>
				
				{foreach from=$table_data item=l name=data_loop}
					{assign var='total_income' value=$total_income+$l->incoming}
					{assign var='total_outgoing' value=$total_outgoing+$l->outgoing}
					{assign var='total_profit' value=$total_profit+$l->profit}

					<tr>
						 <td>{$l->year}</td>
						 <td>{$l->incoming|number_format:2:".":","}</td>
						 <td>{$l->outgoing|number_format:2:".":","}</td>
						 <td style="color:{if $l->profit>0}green{else}red{/if}">{$l->profit}</td>
					</tr>
				{/foreach}
				</tbody>
				<tfoot>
					<tr>
						 <td>Totals</td>
						 <td>{$total_income|number_format:2:".":","}</td>
						 <td>{$total_outgoing|number_format:2:".":","}</td>
						 <td>{$total_profit|number_format:2:".":","}</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
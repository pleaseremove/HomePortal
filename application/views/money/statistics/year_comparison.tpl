{$ci->load->model('money_stats_model')}

<div id="title_bar" class="box_background border_color_bottom">
	<h2>Statistics: Year Comparison</h2>
</div>

<div id="content">
	
	{include file="money/statistics/tab_bar.tpl" active_tab="year_comparison"}
	
	{assign var='last_cat' value=''}
	{assign var='total_last' value=0}
	{assign var='total_sum' value=0}
	{assign var='total_spent' value=0}

	<div class="widget full">
		<div class="widget_title">Year Comparion</div>
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
					</tr>
				</thead>
				<tbody>
				{foreach from=$ci->money_stats_model->year_comparison() item=a name=data_loop}
					{if $last_cat!=$a->top_category}
						{assign var='last_cat' value=$a->top_category}
						<tr>
							<td colspan="13" style="text-align:left;{if !$smarty.foreach.data_loop.first}border-top:1px solid #DADADA;{/if}border-bottom:1px solid #DADADA;">{$a->top_category}</td>
						</tr>
					{/if}
					
					{assign var='total_spent' value=$total_spent+$a->spent}
					{assign var='total_last' value=$total_last+$a->last_year}
					{assign var='total_sum' value=$total_sum+$a->last_year_total}
					
					{if $a->spent==0 || $a->last_year_total==0}
						{assign var='percent_this_year' value=0}
					{else}
						{assign var='percent_this_year' value=($a->spent/$a->last_year_total)*100}
					{/if}
					
					{if $a->last_year==0 || $a->last_year_total==0}
						{assign var='percent_last_year' value=0}
					{else}
						{assign var='percent_last_year' value=($a->last_year/$a->last_year_total)*100}
					{/if}
					
					<tr>
						<td>{$a->category} <span style="background: url('_images/progress_arrow.png') no-repeat;display: block;height: 11px;width: 19px; float:right;margin-left:10px;margin-top:3px;{if $a->spent>$a->last_year}background-position:0px -11px;{/if}"></span></td>
						<td colspan="13" style="overflow:hidden;">
							<div style="width:{$percent_this_year}%;background-color:#6F8FB5;text-align:left;color:white;" title="Last Year Grant Total: {$a->last_year_total}">
								&nbsp;{$a->spent|number_format:2:".":","}
							</div>
						</td>
					</tr>
					<tr style="height:5px;">
						<td style="height:5px;"></td>
						<td style="height:5px;overflow:hidden;" colspan="13">
							<div style="width:{$percent_last_year}%;background-color:#d1d8e1;height:5px;" title="Last Year: {$a->last_year|number_format:2:".":","}"></div>
						</td>
					</tr>

				{/foreach}
				</tbody>
				<tfoot>
				
					{assign var='percent_full_this_year' value=($total_spent/$total_sum)*100}
					{assign var='percent_full_last_year' value=($total_last/$total_sum)*100}

					<tr>
						<td>Total this year<span style="background: url('_images/progress_arrow.png') no-repeat;display: block;height: 11px;width: 19px; float:right;margin-left:10px;margin-top:3px;{if $total_spent>$total_last}background-position:0px -11px;{/if}"></span></td>
						<td colspan="13" style="overflow:hidden;">
							<div style="width:{$percent_full_this_year}%;background-color:#6F8FB5;text-align:left;color:white;" title="Last Year Grant Total: {$total_sum}">
								&nbsp;{$total_spent|number_format:2:".":","}
							</div>
						</td>
					</tr>
					
					<tr style="height:5px;">
						<td style="height:5px;"></td>
						<td style="height:5px;overflow:hidden;" colspan="13">
							<div style="width:{$percent_full_last_year}%;background-color:#d1d8e1;height:5px;" title="Last Year: {$total_last|number_format:2:".":","}"></div>
						</td>
					</tr>
					
				</tfoot>
			</table>
		</div>
	</div>
</div>
<div id="title_bar" class="box_background border_color_bottom">
	<h2>Statistics: Category - {$category->description|default:'All'}</h2>
</div>

<div id="content">

	{include file="money/statistics/tab_bar.tpl" active_tab="category"}

	<form action="money/categories/stats/7">
		<p style="margin: 10px 2%;">
			<label>Start Date</label>
			<input class="date_picker" name="date_range_s[date]" value="{$smarty.post.date_range_s.date}" style="width:70px;" />
			<label style="margin-left:10px">End Date</label>
			<input class="date_picker" name="date_range_e[date]" value="{$smarty.post.date_range_e.date}" style="width:70px;" />
			<label style="margin-left:10px">Category</label>
			<select name="category">
				<option value="0">All</option>
				{foreach from=$categories name=category item=c}
					{if $group != $c->parent}
            {if !$smarty.foreach.category.first}</optgroup>{/if}
            {assign var='group' value=$c->parent}
            <optgroup label="{$group}">
          {/if}
          <option label="{$c->description}" {if $category->id()==$c->id} selected="selected"{/if} value="{$c->id}">{$c->description}</option>
          {if $smarty.foreach.category.last}</optgroup>{/if}
				{/foreach}
			</select>
			<input type="submit" value="Apply" />
		</p>
	</form>

	<div class="widget full">
		<div class="widget_title">Overview</div>
		<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
			<p class="money_stat">
				<span>Total In</span><span style="color:green">&pound;{$money_stats->total_in|number_format:2:'.':','}</span>
			</p>
			<p class="money_stat">
				<span>Total Out</span><span style="color:red">&pound;{$money_stats->total_out|number_format:2:'.':','}</span>
			</p>
			<p class="money_stat">
				<span>Average In</span><span style="color:green">&pound;{$money_stats->average_in|number_format:2:'.':','}</span>
			</p>
			<p class="money_stat">
				<span>Average Out</span><span style="color:red">&pound;{$money_stats->average_out|number_format:2:'.':','}</span>
			</p>
			<p class="money_stat">
				<span>Net Gain/Loss</span><span style="color:{if $money_stats->net_gain_loss<0}red{else}green{/if}">&pound;{$money_stats->net_gain_loss|number_format:2:'.':','}</span>
			</p>
			<p class="money_stat">
				<span>No. Credits</span><span style="color:green">{$money_stats->count_in}</span>
			</p>
			<p class="money_stat">
				<span>No. Debits</span><span style="color:red">{$money_stats->count_out}</span>
			</p>
			<div style="clear:left"></div>
		</div>
	</div>
	
	{include file="money/statistics/day_of_week_distributions_widget.tpl" graph_type='breakdown'}
	
	{include file="money/statistics/day_of_week_distributions_widget.tpl" graph_type='totals'}
	
	{include file="money/statistics/month_distributions_widget.tpl" graph_type='breakdown'}
	
	{include file="money/statistics/month_distributions_widget.tpl" graph_type='totals'}
	
	{include file="money/statistics/numeric_distributions_widget.tpl" widget_type='day_of_month' graph_type='breakdown'}
	
	{include file="money/statistics/numeric_distributions_widget.tpl" widget_type='day_of_month' graph_type='totals'}
	
	{include file="money/statistics/numeric_distributions_widget.tpl" widget_type='week_of_year' graph_type='breakdown'}
	
	{include file="money/statistics/numeric_distributions_widget.tpl" widget_type='week_of_year' graph_type='totals'}
	
</div>

<style type="text/css">
p.money_stat{
	width: 12%;
	padding-left: 1%;
	padding-right: 1%;
}
</style>
<script src="_js/widgets.js" type="text/javascript"></script>
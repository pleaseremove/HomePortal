<div id="title_bar" class="box_background border_color_bottom">
	<h2>Statistics</h2>
</div>

<div id="content">
	<form action="money/statistics">
		<p style="margin: 10px 2%;">
			<label>Year</label>
			<select name="year">
				<option value="2013"{if $smarty.post.year==2013 || ($cur_year==2013 && !$smarty.post.year)} selected="selected"{/if}>2013</option>
				<option value="2012"{if $smarty.post.year==2012 || ($cur_year==2012 && !$smarty.post.year)} selected="selected"{/if}>2012</option>
			</select>
			<label>Month</label>
			<select name="month">
				<option value="1"{if $smarty.post.month==1 || ($cur_month==1 && !$smarty.post.month)} selected="selected"{/if}>January</option>
				<option value="2"{if $smarty.post.month==2 || ($cur_month==2 && !$smarty.post.month)} selected="selected"{/if}>February</option>
				<option value="3"{if $smarty.post.month==3 || ($cur_month==3 && !$smarty.post.month)} selected="selected"{/if}>March</option>
				<option value="4"{if $smarty.post.month==4 || ($cur_month==4 && !$smarty.post.month)} selected="selected"{/if}>April</option>
				<option value="5"{if $smarty.post.month==5 || ($cur_month==5 && !$smarty.post.month)} selected="selected"{/if}>May</option>
				<option value="6"{if $smarty.post.month==6 || ($cur_month==6 && !$smarty.post.month)} selected="selected"{/if}>June</option>
				<option value="7"{if $smarty.post.month==7 || ($cur_month==7 && !$smarty.post.month)} selected="selected"{/if}>July</option>
				<option value="8"{if $smarty.post.month==8 || ($cur_month==8 && !$smarty.post.month)} selected="selected"{/if}>August</option>
				<option value="9"{if $smarty.post.month==9 || ($cur_month==9 && !$smarty.post.month)} selected="selected"{/if}>September</option>
				<option value="10"{if $smarty.post.month==10 || ($cur_month==10 && !$smarty.post.month)} selected="selected"{/if}>October</option>
				<option value="11"{if $smarty.post.month==11 || ($cur_month==11 && !$smarty.post.month)} selected="selected"{/if}>November</option>
				<option value="12"{if $smarty.post.month==12 || ($cur_month==12 && !$smarty.post.month)} selected="selected"{/if}>December</option>
			</select>
			<input type="submit" value="Update" />
		</p>
	</form>

	{include file="money/statistics/accounts_overview_widget.tpl"}
	
	{include file="money/statistics/category_overview_widget.tpl"}
	
	{if !$smarty.post.month || ($smarty.post.month==$cur_month && $smarty.post.year==$cur_year)}
		{include file="money/statistics/balances_widget.tpl"}
		{include file="money/statistics/category_distribution_widget.tpl"}
		{include file="money/statistics/year_cat_breakdown_widget.tpl"}
		{include file="money/statistics/category_progress_widget.tpl"}
	{else}
		{include file="money/statistics/year_cat_breakdown_widget.tpl"}
		{include file="money/statistics/category_distribution_widget.tpl"}
	{/if}
	<div style="clear:both">&nbsp;</div>
</div>

<style type="text/css">
	#account_breakdown table.jqplot-table-legend,
	#category_breakdown table.jqplot-table-legend{
		right: -30px !important;
		top: -2px !important;
	}

	table.jqplot-table-legend{
		/*margin: 2px -26px 0 0px;*/
		font-size: 0.70em;
	}
	
	table.jqplot-table-legend td{
		padding-left: 0;
	}
</style>
<script src="_js/widgets.js" type="text/javascript"></script>
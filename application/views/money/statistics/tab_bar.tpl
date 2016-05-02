<ul class="tab_bar widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
	<li><a {if $active_tab=="overview"}class="current"{/if} data-selection="money-statistics" href="money/statistics/overview">Overview <br />Statistics</a></li>
	<li><a {if $active_tab=="account"}class="current"{/if} data-selection="money-statistics" href="money/statistics/account_breakdown">Account <br />Statistics</a></li>
	<li><a {if $active_tab=="category"}class="current"{/if} data-selection="money-statistics" href="money/categories/stats/0">Category <br />Statistics</a></li>
	<li><a {if $active_tab=="year_comparison"}class="current"{/if} data-selection="money-statistics" href="money/statistics/year_comparison">Category <br />Comparison</a></li>
	<li><a {if $active_tab=="cat_debits"}class="current"{/if} data-selection="money-statistics" href="money/statistics/category_aggregate/debits">Category <br />Spending</a></li>
	<li><a {if $active_tab=="cat_credits"}class="current"{/if} data-selection="money-statistics" href="money/statistics/category_aggregate/credits">Category <br />Income</a></li>
	<li><a {if $active_tab=="income_outgoing"}class="current"{/if} data-selection="money-statistics" href="money/statistics/income_outgoing">Income / <br />Outgoings</a></li>
</ul>
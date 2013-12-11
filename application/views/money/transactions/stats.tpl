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
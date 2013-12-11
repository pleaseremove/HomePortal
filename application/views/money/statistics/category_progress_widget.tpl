{$ci->load->model('money_stats_model')}

<style type="text/css">
	#cat_progress_widget .progress{
		position: relative;
		height: 40px;
		margin-bottom: 5px;
		background-color: #fff;
		padding-top: 10px;
	}
	
	#cat_progress_widget .cat_name{
		float: left;
    width: 66px;
    height: 34px;
    padding-left: 10px;
    font-weight: bold;
	}
	
	#cat_progress_widget .progress_bar_main{
		width: 250px;
		position: relative;
		float: left;
		height: 20px;
	}
	
	#cat_progress_widget .progress_bar_main span{
		z-index: 100;
    position: absolute;
    top: 0;
    color: #fff;
    
	}
	
	#cat_progress_widget .progress_bar_main span.amount{
		left: 2px;
	}
	
	#cat_progress_widget .progress_bar_main div{
		background: url('_images/progress_gradient_small_light.png') no-repeat;
		height: 20px;
    position: absolute;
    top: 0;
	}
	
	#cat_progress_widget .progress_bar_main span.percent{
		position: absolute;
		right: -35px;
		color: #122333;
	}
	
	#cat_progress_widget .progress_bar_main span.percent_diff{
		position: absolute;
		right: -70px;
		top: 10px;
		background: url('_images/progress_arrow.png') no-repeat top;
		display: block;
		width: 19px;
		height: 11px;
	}
	
	#cat_progress_widget .progress_bar_main span.percent_diff.down{
		background-position: bottom;
	}
	
	#cat_progress_widget .progress_bar_last{
		float: left;
    height: 5px;
    margin-left: 0px;
    margin-top: 5px;
    position: relative;
    width: 250px;
	}
	
	#cat_progress_widget .progress_bar_last div{
		background: url('_images/progress_gradient_small_light.png') no-repeat;
		height: 5px;
    position: absolute;
    top: 0;
	}
	
	#cat_progress_widget .progress_bar_last span.percent{
		color: #122333;
    font-size: 10px;
    position: absolute;
    right: -35px;
    top: -5px;
	}
	
	#cat_progress_widget_stats {
    font-weight: bold;
    padding: 10px 1px;
	}
</style>

{assign var='cur_spend_total' value=0}
{assign var='last_spend_total' value=0}
{assign var='lastyear_spend_total' value=0}

<div class="widget" id="cat_progress_widget">
	<div class="widget_title">Category Progress</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		{foreach from=$ci->money_stats_model->current_month_progress() item=c}
			{assign var='cur_spend_total' value=$cur_spend_total+$c->spent}
			{assign var='last_spend_total' value=$last_spend_total+$c->last_month}
			{assign var='lastyear_spend_total' value=$lastyear_spend_total+$c->last_year}
			<div class="progress border_color_bottom border_color_top border_color_left border_color_right">
				<div class="cat_name">{$c->category}</div>
				<div title="&pound;{$c->spent}" class="progress_bar_main border_color_bottom border_color_top border_color_left border_color_right">
					<span class="amount">&pound; {$c->spent}</span>
					<div style="width:{$c->percent}%"></div>
					<span class="percent">{$c->percent}&#37;</span>
					<span class="percent_diff {if $c->percent > $c->percent_last_month}down{/if}"></span>
				</div>
				<div title="&pound;{$c->last_month}" class="progress_bar_last border_color_bottom border_color_top border_color_left border_color_right">
					<div style="width:{$c->percent_last_month}%"></div>
					<span class="percent">{$c->percent_last_month}&#37;</span>
				</div>
				{*<div title="&pound;{$c->last_year}" class="progress_bar_last border_color_bottom border_color_top border_color_left border_color_right">
					<div style="width:{$c->percent_last_year}%"></div>
					<span class="percent">{$c->percent_last_year}&#37;</span>
				</div>*}
				
			</div>
		{foreachelse}
			<p>No data this month yet</p>
		{/foreach}
		<div id="cat_progress_widget_stats">
			{*assign var='total_change' value="`($cur_percent_total \ $last_percent_total)*100`"*}
			{if $cur_spend_total!=0 && $last_spend_total!=0}Current spend against last spend: {(($cur_spend_total/$last_spend_total)*100)|string_format:"%.2f"}&#37;{/if}
			{*<br />Last Year: &nbsp; &pound;{$lastyear_spend_total|string_format:"%.2f"}*}
			<br />Last Month: &nbsp; &pound;{$last_spend_total|string_format:"%.2f"}
			<br />Current: &nbsp; &pound;{$cur_spend_total|string_format:"%.2f"}
		</div>
	</div>
</div>
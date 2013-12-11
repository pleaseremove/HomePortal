{$ci->load->model('money_stats_model')}

<div class="widget full">
	<div class="widget_title">Total Balance</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		<div id="total_balance" class="graph" style="width:97%;height:300px;"></div>
	</div>
</div>

{*<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.trendline.min.js"></script>*}

<script type="text/javascript">
	var balance_over_time = [{foreach from=$ci->money_stats_model->balance_over_time($smarty.post.account_id) name=acc_break item=b key=b_id}['{$b_id}',{$b}]{if !$smarty.foreach.acc_break.last},{/if}{/foreach}];
	{literal}
	$(function(){
		$.jqplot.config.enablePlugins = true;
		
		plot2 = $.jqplot('total_balance',[balance_over_time],{
			axes:{xaxis:{renderer:$.jqplot.DateAxisRenderer}},
			series:[{lineWidth:1, markerOptions:{show:false}}],
			rendererOptions:{
				smooth: true
			},
			cursor:{
				show: true
     	}
	  });
	});
	{/literal}
</script>
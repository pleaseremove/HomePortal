{$ci->load->model('money_stats_model')}

<div class="widget">
	<div class="widget_title">Weekday {if $graph_type =='totals'}Totals{else}Breakdown{/if}</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		<div id="weekday_stats_{$graph_type}" class="graph" style="width:97%;height:300px;"></div>
	</div>
</div>

<script type="text/javascript">
	{assign var='weekday_stats' value=$ci->money_stats_model->day_of_week_distributions($category->id(),$smarty.post.date_range_s.date,$smarty.post.date_range_e.date)}
	
	{if $graph_type =='breakdown'}
		var weekday_stats_{$graph_type}_d = [{foreach from=$weekday_stats name=ws_l item=d key=dk}['{$dk}',{$d.tran_min},{$d.tran_max},{$d.tran_avg}]{if !$smarty.foreach.ws_l.last},{/if}{/foreach}];
	{else}
		var weekday_stats_{$graph_type}_d = [{foreach from=$weekday_stats name=ws_l item=d key=dk}['{$dk}',{$d.tran_sum}]{if !$smarty.foreach.ws_l.last},{/if}{/foreach}];
	{/if}
	
	{literal}
	$(function(){
		$.jqplot.config.enablePlugins = true; 
		$.jqplot('weekday_stats_{/literal}{$graph_type}{literal}',[weekday_stats_{/literal}{$graph_type}{literal}_d],{
	    {/literal}
	    {if $graph_type=='breakdown'}
	    	{literal}
	    		series: [
	    					{renderer:$.jqplot.OHLCRenderer, rendererOptions:{}}
	    		],
	    	{/literal}
	    {/if}
	    {literal}
	    axesDefaults:{},
	    seriesDefaults: {
	    	lineWidth: 1,
	    },
	    axes: {
				xaxis: {
					renderer:$.jqplot.CategoryAxisRenderer,
					ticks:['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
				}
      },
	    grid: {
	      drawBorder: false,
	      shadow: false
	    },
	  });
	});
	{/literal}
</script>
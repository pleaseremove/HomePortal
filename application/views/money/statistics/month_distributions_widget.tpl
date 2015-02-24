{$ci->load->model('money_stats_model')}

{assign var='month_stats' value=$ci->money_stats_model->month_of_year_distributions($category->id(),$smarty.post.date_range_s.date,$smarty.post.date_range_e.date)}

<div class="widget">
	<div class="widget_title">Month {if $graph_type =='totals'}Totals{else}Breakdown{/if}</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		<div id="month_stats_{$graph_type}" class="graph" style="width:97%;height:300px;"></div>
	</div>
</div>

<script type="text/javascript">
	
	{if $graph_type =='breakdown'}
		var widget_stats_{$graph_type}_d = [{foreach from=$month_stats name=ms_l item=m key=mk}['{$mk}',{$m.tran_min},{$m.tran_max},{$m.tran_avg}]{if !$smarty.foreach.ms_l.last},{/if}{/foreach}];
	{else}
		var widget_stats_{$graph_type}_d = [{foreach from=$month_stats name=ms_l item=m key=mk}['{$mk}',{$m.tran_sum}]{if !$smarty.foreach.ms_l.last},{/if}{/foreach}];
	{/if}
	
	{literal}
	$(function(){
		$.jqplot.config.enablePlugins = true; 
		$.jqplot('month_stats_{/literal}{$graph_type}{literal}',[widget_stats_{/literal}{$graph_type}{literal}_d],{
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
	    	lineWidth: 1
	    },
	    axes: {
				xaxis: {
					renderer:$.jqplot.CategoryAxisRenderer,
					ticks:['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
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
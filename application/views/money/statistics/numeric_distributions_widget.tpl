{$ci->load->model('money_stats_model')}

{assign var='widget_stats' value=$ci->money_stats_model->numeric_distributions($widget_type,$category->id(),$smarty.post.date_range_s.date,$smarty.post.date_range_e.date)}

<div class="widget full">
	<div class="widget_title">{$widget_stats.name} {if $graph_type =='totals'}Totals{else}Breakdown{/if}</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		<div id="month_stats_{$widget_type}_{$graph_type}" class="graph" style="width:97%;height:300px;"></div>
	</div>
</div>

<script type="text/javascript">

	{if $graph_type =='breakdown'}
		var widget_stats_{$widget_type}_{$graph_type}_d = [{foreach from=$widget_stats.data name=ws_l item=d key=dk}['{$dk}',{$d.tran_min},{$d.tran_max},{$d.tran_avg}]{if !$smarty.foreach.ws_l.last},{/if}{/foreach}];
	{else}
		var widget_stats_{$widget_type}_{$graph_type}_d = [{foreach from=$widget_stats.data name=ws_l item=d key=dk}['{$dk}',{$d.tran_sum}]{if !$smarty.foreach.ws_l.last},{/if}{/foreach}];
	{/if}

	{literal}
	$(function(){
		$.jqplot.config.enablePlugins = true; 
		$.jqplot('month_stats_{/literal}{$widget_type}_{$graph_type}{literal}',[widget_stats_{/literal}{$widget_type}_{$graph_type}{literal}_d],{
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
				xaxis:{min:{/literal}{$widget_stats.start}{literal},max:{/literal}{$widget_stats.end}{literal},autoscale:false,tickInterval:1}
      },
	    grid: {
	      drawBorder: false,
	      shadow: false
	    },
	  });
	});
	{/literal}
</script>
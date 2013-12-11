{$ci->load->model('money_stats_model')}

<div class="widget">
	<div class="widget_title">Weekday Breakdown</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		<div id="weekday_stats" class="graph" style="width:97%;height:300px;"></div>
	</div>
</div>

<script type="text/javascript">
	{assign var='weekday_stats' value=$ci->money_stats_model->day_of_week_distributions($category->id(),$smarty.post.date_range_s.date,$smarty.post.date_range_e.date)}
	
	var weekday_stats_d = [{foreach from=$weekday_stats name=ws_l item=d key=dk}['{$dk}',{$d.tran_min},{$d.tran_max},{$d.tran_avg}]{if !$smarty.foreach.ws_l.last},{/if}{/foreach}];
	var ticks = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
	{literal}
	$(function(){
		$.jqplot.config.enablePlugins = true; 
		$.jqplot('weekday_stats',[weekday_stats_d],{
	    series: [{renderer:$.jqplot.OHLCRenderer, rendererOptions:{}}],
	    axesDefaults:{},
	    seriesDefaults: {
	    	showMarker: false,
	    	lineWidth: 4,
	      rendererOptions: {
	        smooth: true,
	      }
	    },
	    axes: {
				xaxis: {
					renderer:$.jqplot.CategoryAxisRenderer,
					ticks:ticks
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
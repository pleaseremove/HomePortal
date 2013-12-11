{$ci->load->model('money_stats_model')}

{assign var='month_stats' value=$ci->money_stats_model->month_of_year_distributions($category->id(),$smarty.post.date_range_s.date,$smarty.post.date_range_e.date)}

<div class="widget">
	<div class="widget_title">Month Breakdown</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		<div id="month_stats" class="graph" style="width:97%;height:300px;"></div>
	</div>
</div>

<script type="text/javascript">
	
	var widget_stats_d = [{foreach from=$month_stats name=ms_l item=m key=mk}['{$mk}',{$m.tran_min},{$m.tran_max},{$m.tran_avg}]{if !$smarty.foreach.ms_l.last},{/if}{/foreach}];
	var widget_stats_dc = [10,20,30,40,50,60,70,80,90,100,110,120];
	
	{literal}
	$(function(){
		$.jqplot.config.enablePlugins = true; 
		$.jqplot('month_stats',[widget_stats_d],{
	    series: [
	    					{renderer:$.jqplot.OHLCRenderer, rendererOptions:{}}
	    ],
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
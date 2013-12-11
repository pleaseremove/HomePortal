{$ci->load->model('money_stats_model')}

<div class="widget full">
	<div class="widget_title">Category Overview</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		<div id="category_breakdown" class="graph" style="width:98%;height:300px;">
			<div id="category_breakdown_click" style="position:absolute; right: 0px; bottom:20px;"></div>
		</div>
	</div>
</div>

{assign var="cat_breakdown" value=$ci->money_stats_model->calc_category_breakdown($smarty.post.year)}
{*foreach from=$cat_breakdown.cats item=cat*}

<script type="text/javascript">
	var cat_break = [{foreach from=$cat_breakdown.out name=cat_break_o item=a key=c_id}[{foreach from=$a item=ab name=cat_break}{$ab}{if !$smarty.foreach.cat_break.last},{/if}{/foreach}],{/foreach}[{foreach from=$cat_breakdown.in name=cat_break_in item=ain key=c_id}{$ain}{if !$smarty.foreach.cat_break_in.last},{/if}{/foreach}]];
	var cat_set = {$cat_breakdown.cats};
	var cat_series = [{foreach from=$cat_breakdown.catser item=cs}{literal}{label:'{/literal}{$cs.name}',color:'#{$cs.colour}',showMarker:false,renderer: $.jqplot.BarRenderer{literal}},{/literal}{/foreach}{literal}{label: 'Incoming', renderer: $.jqplot.LineRenderer, disableStack: true}{/literal}];
	{literal}
	$(function(){
		plot3 = $.jqplot('category_breakdown',cat_break,{
	   	stackSeries: true,
	   	series: cat_series,
	    legend: {
	      show: true,
	      placement: 'outsideGrid'
	    },
	    seriesDefaults: {
	      rendererOptions: {
	        smooth: true,
	        barMargin: 10,
	        barPadding: 8
	      }
	    },
	    grid: {
	      drawBorder: false,
	      shadow: false
	    },
	    axes: {
	     	xaxis:{
	     	  renderer: $.jqplot.CategoryAxisRenderer,
	          ticks: ['January','Febuary','March','April','May','June','July','August','September','October','November','December']
	        },
	     	yaxis:{
	     	  padMin:0
	     	}
	    }
	  });
	  
	  $('#category_breakdown').bind('jqplotDataClick',function(ev,seriesIndex,pointIndex,data){
	  	$('#category_breakdown_click').html('<p>Amount: &pound;'+data[1]+'</p><p><a href="#">View</a></p>');
	  	$('#category_breakdown_click').on('click','a',function(){
	  			console.log('month:'+data[0]+' cat_id:'+cat_set[seriesIndex]);
	  	});
	  	/*'is_ajax=1&filter%5Bcategory_id%5D='+cat_set[seriesIndex]*/
	  });
	});
	{/literal}
	</script>
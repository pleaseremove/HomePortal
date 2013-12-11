{$ci->load->model('money_stats_model')}
{assign var='data_set' value=$ci->money_stats_model->calc_category_distribution($smarty.post.account_id)}
{if count($data_set)>0}
<div class="widget">
		<div class="widget_title">Category Distribution</div>
		<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
			<div id="category_distribution" class="graph" style="width:98%;height:300px;"></div>
		</div>
	</div>
	
	<script type="text/javascript">
		var cat_distrib = [{foreach from=$data_set item=cat name=cat_d}['{$cat.description}',{$cat.amount}]{if !$smarty.foreach.cat_d.last},{/if}{/foreach}];
		var cat_distrib_c = [{foreach from=$data_set item=c name=c_d}"#{$c.color}"{if !$smarty.foreach.c_d.last},{/if}{/foreach}];
		{literal}
		$(function(){
			var plot4 = jQuery.jqplot ('category_distribution', [cat_distrib],{
				seriesDefaults: {
					renderer: jQuery.jqplot.PieRenderer,
					rendererOptions: {
						showDataLabels: true
					}
				},
				seriesColors: cat_distrib_c,
				grid: {
		      drawBorder: false,
		      shadow: false,
		      background: '#F7F8FA'
		    },
				legend: { show:true, location: 'e' }
			});
		});
		{/literal}
	</script>
{/if}
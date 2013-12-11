{$ci->load->model('money_stats_model')}

<div class="widget full">
	<div class="widget_title">Accounts Overview</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		<div id="account_breakdown" class="graph" style="width:97%;height:300px;"></div>
	</div>
</div>
	
<script type="text/javascript">
	{assign var='stats' value=$ci->money_stats_model->calc_accounts_chart($smarty.post.year,$smarty.post.month)}
	var account_breakdown = [{foreach from=$stats.data name=acc_break item=a key=a_id}[{$a}]{if !$smarty.foreach.acc_break.last},{/if}{/foreach}];
	var accounts = [{foreach from=$stats.accounts name=accc_break item=ac}{literal}{label:'{/literal}{$ac.name}',color:'#{$ac.colour}'{literal}}{/literal}{if !$smarty.foreach.accc_break.last},{/if}{/foreach}];
	{literal}
	$(function(){
		plot2 = $.jqplot('account_breakdown',account_breakdown,{
	    series: accounts,
	    legend: {
	      show: true,
	      placement: 'outsideGrid'
	    },
	    seriesDefaults: {
	    	showMarker: false,
	    	lineWidth: 2,
	      rendererOptions: {
	        smooth: true,
	      }
	    },
	    grid: {
	      drawBorder: false,
	      shadow: false
	    },
	    axes: {
	     	xaxis:{min:1,max:31,autoscale:false,tickInterval:1}
	    },
	    cursor:{
				show: true
     	}
	  });
	});
	{/literal}
</script>
<div id="title_bar" class="box_background border_color_bottom">
	<h2>Overview</h2>
</div>
<div id="content">

	<div class="widget">
		<div class="widget_title">Birthdays &amp; Anniversaries</div>
		<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
			<div class="ba_colum">
				{foreach from=$bsandas item=ba name=ba_loop}
					{if $smarty.foreach.ba_loop.index % 5 == 0 && !$smarty.foreach.ba_loop.first}
					</div>
					<div class="ba_colum">
					{/if}
					<div class="widget_b_a">
						<div class="cal">
							<span>{$ba->event_date|date_format:'%b'|upper}</span>
							{$ba->event_date|date_format:'%e'}
						</div>
						<p class="{if $ba->event_type=='b'}bd{else}an{/if}">
							<a data-selection="contacts" href="contacts/view/{$ba->contact}">{$ba->name|capitalize}</a>
						</p>
						<p class="small">
							{if $ba->event_type=='b'}{if $ba->days_to_event==0}is {$ba->new_age} today.{else}will be {$ba->new_age} in {$ba->days_to_event} {if $ba->days_to_event==1}day{else}days{/if} time{/if}{else}{if $ba->days_to_event==0}is together {$ba->new_age} {if $ba->new_age==1}year{else}years{/if} today.{else}will be together for {$ba->new_age} {if $ba->new_age==1}year{else}years{/if} in {$ba->days_to_event} {if $ba->days_to_event==1}day{else}days{/if}{/if}{/if}
						</p>
					</div>
				{foreachelse}
					<p>No up and coming birthdays and anniversaries</p>
				{/foreach}
			</div>
			<div style="clear:both;height:0px;">&nbsp;</div>
		</div>
	</div>
	
	<div class="widget">
	<div class="widget_title">Events</div>
		<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
			{foreach from=$events item=e}
				<p>{$e->start_date|date_format:'%b %e'} {if $e->all_day==1}All Day{/if} - <a data-menu-click="calendar" class="model" href="calendar/event/{$e->id()}">{$e->title}</a></p>
			{foreachelse}
				<p>No up and coming events</p>
			{/foreach}
		</div>
	</div>
	
	{if $ci->session->userdata('public_space')!=1}
	{include file="money/statistics/balances_widget.tpl"}
	{include file="money/statistics/category_progress_widget.tpl"}
	{/if}
	<script src="_js/widgets.js" type="text/javascript"></script>
</div>
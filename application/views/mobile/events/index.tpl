<a href="/mobile/events/edit/0" data-role="button" data-theme="a" data-icon="plus">New Event</a>

<div data-role="navbar">
	<ul>
		<li><a href="/mobile/events/{$year_p.y}/{$year_p.m}/" data-icon="arrow-l" data-iconpos="left">Prev</a></li>
		<li><a href="/mobile/events/{$year_n.y}/{$year_n.m}/" data-icon="arrow-r" data-iconpos="right">Next</a></li>
	</ul>
</div><!-- /navbar -->

<h2>{date('F Y',mktime(0,0,0,$month,1,$year))}</h2>
<ul data-role="listview">
	{foreach from=$events item=day key=day_num}
		<li data-role="list-divider">{date('jS - l',mktime(0,0,0,$month,$day_num,$year))}{if $day_num==date('j')} <i>Today</i>{/if}</li>
		{foreach from=$day item=e name=event_list}
			<li>{if $e.type=='c'}<a href="/mobile/events/edit/{$e.id}">{/if}{$e.title}{if $e.type=='c'}{if $e.all_day==0} -{$e.start_date|date_format:'%l:%M%p'}-{$e.end_date|date_format:'%l:%M%p'}{else} - All Day{/if}</a>{/if}</li>
		{/foreach}
	{/foreach}
</ul>
<br />
{*<p><a href="mobile/events/{$year_p.y}/{$year_p.m}/">Prev</a> | <a href="mobile/events/{$year_n.y}/{$year_n.m}/">Next</a></p>*}
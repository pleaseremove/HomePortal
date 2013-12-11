<p>Daily update from HomePortal with your up and coming events and tasks</p>

{foreach $ci->events_list item=e name=l_event_list}
	{if $smarty.foreach.l_event_list.first}<p><h4>Todays Events</h4>{/if}
		{$e->title}{if $e->all_day==0} -{$e->start_time|date_format:'%l:%M%p'}-{$e->end_time|date_format:'%l:%M%p'}{else} - All Day{/if}{if !$smarty.foreach.l_event_list.last}<br />{/if}
	{if $smarty.foreach.l_event_list.last}</p>{/if}
{/foreach}

{foreach $ci->banda_list item=b name=l_banda_list}
	{if $smarty.foreach.l_banda_list.first}<p><h4>Birthdays &amp; Anniversaries</h4>{/if}
		{if $b->event_type=='b'}Birthday{else}Anniversary{/if}: {$b->first_name} {$b->last_name} - {$b->event_date|date_format:'%b %e'}{if !$smarty.foreach.l_banda_list.last}<br />{/if}
	{if $smarty.foreach.l_banda_list.last}</p>{/if}
{/foreach}

{foreach $ci->tasks_list item=t name=l_tasks_list}
	{if $smarty.foreach.l_tasks_list.first}<p><h4>Due Tasks</h4>{/if}
		{$t->name} - {$t->date_due|date_format}{if !$smarty.foreach.l_tasks_list.last}<br />{/if}
	{if $smarty.foreach.l_tasks_list.last}</p>{/if}
{/foreach}
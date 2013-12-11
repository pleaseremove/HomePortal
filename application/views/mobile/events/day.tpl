<ul data-role="listview" data-autodividers="true" data-divider-theme="b">
	{foreach from=$events item=e}
		<li><a href="/mobile/events/edit/{$e->event_id}" data-transition="slide">{$e->title|capitalize}</a></li>
	{/foreach}
</ul>
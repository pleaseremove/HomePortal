<ul data-role="listview" data-autodividers="true" data-divider-theme="b" data-filter="true">
	{foreach from=$contacts item=c}
		<li><a href="/mobile/contacts/view/{$c->id()}" data-transition="slide">{$c->first_name|capitalize} {$c->last_name|capitalize}</a></li>
	{/foreach}
</ul>
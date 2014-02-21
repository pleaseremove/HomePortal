<ul data-role="listview" data-autodividers="true" data-divider-theme="b" data-filter="true">
	{foreach from=$tasks item=t}
		<li><a href="/mobile/tasks/view/{$t->id()}" data-transition="slide">{$t->name|capitalize}</a></li>
	{/foreach}
</ul>
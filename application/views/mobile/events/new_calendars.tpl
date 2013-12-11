{foreach from=$month_set item=cm}
	{$ci->calendar->generate($cm[1],$cm[0])}
{/foreach}
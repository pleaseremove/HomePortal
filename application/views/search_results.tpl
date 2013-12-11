Results:
{foreach from=$results.data item=i}
				  <div class="search_result {$i.type}">
				    <a data-selection="{$i.selection}" href="{$i.link}"{if $i.modal==1} class="model"{/if}>{$i.text}</a>
				  </div>
				{/foreach}
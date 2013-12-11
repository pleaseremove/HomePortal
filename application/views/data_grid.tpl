<div id="title_bar" class="box_background border_color_bottom">
	<h2>{$section_title}</h2>
	{if isset($extra_data)}<span id="extra_button" class="inline_button">Extra Details<span></span></span>{/if}
	{if isset($delete)}<button id="delete_open">Select to delete</button>{/if}
	<div id="titlebar_right">
		{foreach from=$title_buttons item=b}
			{$b}
		{/foreach}
	</div>
</div>

{if isset($extra_data)}
<div id="extra_fold" class="border_color_bottom">
	{$extra_data}
</div>
{/if}

<div class="data_grid" data-filter="/{$ci->router->directory}{if $ci->router->directory!=''}/{/if}{$ci->router->class}/filter" data-limit="100">
	{foreach from=$filters item=f name=filter_loop}

		{if $smarty.foreach.filter_loop.first}
			<div id="filter" class="box_background border_color_bottom">
		{/if}
		
		{if $f.type=='select'}
			<div class="filter_item">
				<span>{$f.label}</span>
				<select name="filter[{$f.name}]">
					{foreach from=$f.options item=fo key=value}
						{if is_array($fo)}
							<optgroup label="{$value}">
								<option value="{foreach from=$fo item=ifo key=ivalue name=inner_all}{$ivalue}{if !$smarty.foreach.inner_all.last},{/if}{/foreach}">All - {$value}</option>
								{foreach from=$fo item=ifo key=ivalue}
									<option {if (isset($smarty.post.filter[$f.name]) && $smarty.post.filter[$f.name]==$ivalue) || (isset($f.default) && $f.default==$ivalue)} selected="selected"{/if} value="{$ivalue}">{$ifo}</option>
								{/foreach}
							</optgroup>
						{else}
							<option {if (isset($smarty.post.filter[$f.name]) && $smarty.post.filter[$f.name]==$value) || (isset($f.default) && $f.default==$value)} selected="selected"{/if} value="{$value}">{$fo}</option>
						{/if}
					{/foreach}
				</select>
			</div>
		{elseif $f.type=='data_range'}
			<div class="filter_item">
				<span>Start Data</span>
				<input style="width:70px;" name="date_range_s[{$f.start_name}]" class="date_picker" />
			</div>
			<div class="filter_item">
				<span>End Data</span>
				<input style="width:70px;" name="date_range_e[{$f.end_name}]" class="date_picker" />
			</div>
		{/if}
		
		{if $smarty.foreach.filter_loop.last}
				<button id="apply_filter">Apply</button>
		  </div><!--#filter-->
		{/if}
	
	{/foreach}
	
	<div id="content" class="">
		<table class="data_grid">
			<thead class="box_shadow">
				<tr>
					{if isset($delete)}<th class="delete_line">Delete</th>{/if}
					{foreach from=$headers item=header}
						<th{if isset($header.sort)} data-sort="{$header.sort}"{/if}>{$header.label}</th>
					{/foreach}
				</tr>
			</thead>
			<tbody>
				{include file="$inner_loop.tpl"}
			</tbody>
		</table>
	</div><!--#content-->
</div><!--.data_grid-->
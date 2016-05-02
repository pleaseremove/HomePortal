{foreach from=$contacts item=c}
	<tr data-click="contacts/view/{$c->id()}" data-selection="contacts">
		{if isset($delete)}<td class="delete_line"><input type="checkbox" name="to_delete[{$c->id()}]" /></td>{/if}
		<td>{$c->first_name|capitalize}</td>
		<td>{$c->last_name|capitalize}</td>
		<td{if isset($c->birthday)} title="{$c->age()} Years Old"{/if}>{$c->birthday|date_format}</td>
		<td>{$c->mobile_phone}</td>
		<td>{$c->home_phone}</td>
		<td><a href="mailto:{$c->email}" class="click-through">{$c->email}</a></td>
		<td {if isset($c->facebook)}data-click="http://www.facebook.com/profile.php?id={$c->facebook}" class="new_window"{/if}>{if isset($c->facebook)}View{/if}</td>
		<td>{$c->sms_count}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="7">No Contacts Found</td>
	</tr>
{/foreach}
{foreach from=$users item=u}
	<tr data-click="settings/users/view/{$u->id()}" data-title="{$u->name|capitalize}" class="model">
		<td>{$u->name|capitalize}</td>
		<td>{$u->username}</td>
		<td>{$u->last_logged_in|date_format|default:''}</td>
		<td>{if $u->is_admin==1}Yes{else}No{/if}</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="4">No Users Found</td>
	</tr>
{/foreach}
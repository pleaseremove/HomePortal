<form action="settings/users/save">
	<div class="form_50" style="margin-bottom:15px;"><label>Name</label><input type="text" name="name" value="{$user->name}"></div>
	
	<div class="form_50" style="margin-bottom:15px;"><label>Username</label><input type="text" name="username" value="{$user->username}"></div>
	
	{if $currentuser->is_admin()}
	<div class="form_50" style="margin-bottom:15px;">
		<label>Admin</label>
		<select name="is_admin">
			<option value="0" {if isset($user->is_admin) && $user->is_admin==0} selected="selected"{/if}>No</option>
			<option value="1" {if isset($user->is_admin) && $user->is_admin==1} selected="selected"{/if}>Yes</option>
		</select>
	</div>
	{/if}
	
	<div class="{if $currentuser->is_admin()}form_50{else}form_100{/if}" style="margin-bottom:15px;">
		<label>E-mail</label>
		<input type="text" name="email" value="{$user->email}">
	</div>
	
	<div class="form_50">
		<label>E-mail Alerts</label>
		<select name="email_alerts">
			<option value="0" {if isset($user->email_alerts) && $user->email_alerts==0} selected="selected"{/if}>No</option>
			<option value="1" {if isset($user->email_alerts) && $user->email_alerts==1} selected="selected"{/if}>Yes</option>
		</select>
	</div>
	
	<div class="form_50">
		<label>Alerts reminder days</label>
		<input type="text" name="reminder_days" value="{$user->reminder_days}">
	</div>
	
	<input type="hidden" name="user_id" value="{$user->id()|default:'0'}">
</form>
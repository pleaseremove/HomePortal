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
	
	<div class="form_100 form_break"></div>
	
	<div class="form_50" style="margin-bottom:15px;">
		<label>E-mail Alerts</label>
		<select name="email_alerts">
			<option value="0" {if isset($user->email_alerts) && $user->email_alerts==0} selected="selected"{/if}>No</option>
			<option value="1" {if isset($user->email_alerts) && $user->email_alerts==1} selected="selected"{/if}>Yes</option>
		</select>
	</div>
	
	<div class="form_50" style="margin-bottom:15px;">
		<label>Alerts reminder days</label>
		<input type="text" name="reminder_days" value="{$user->reminder_days}">
	</div>
	
	{if $currentuser->is_admin() || $user->id() == $currentuser->id() || $user->isNew()}
	
	<div class="form_100 form_break"></div>
	
	{if $user->id() == $currentuser->id() && !$user->isNew()}
	
	<div class="form_50">
		<label>Old Password</label>
		<input type="text" name="old_password" value="">
	</div>
	
	<div class="form_100 form_break" style="border:none;"></div>
	
	{/if}
	
	<div class="form_50" style="margin-bottom:15px;">
		<label>New Password</label>
		<input type="text" name="new_password1" value="">
	</div>
	
	<div class="form_50" style="margin-bottom:15px;">
		<label>New Password again</label>
		<input type="text" name="new_password2" value="">
	</div>
	
	{/if}
	
	<input type="hidden" name="user_id" value="{$user->id()|default:'0'}">
</form>
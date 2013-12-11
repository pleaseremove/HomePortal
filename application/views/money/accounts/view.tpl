<form action="money/accounts/save">
	<div class="form_30">
		<label>Name</label><input type="text" name="name" value="{$account->name}">
	</div>
	
	<div class="form_30">
		<label>Type</label>
		<select name="type">
			<option value="Flex" {if $account->type=="Flex"}selected="selected"{/if}>Flex</option>
			<option value="ISA" {if $account->type=="ISA"}selected="selected"{/if}>ISA</option>
			<option value="Cash" {if $account->type=="Cash"}selected="selected"{/if}>Cash</option>
		</select>
	</div>
	
	<div class="form_30">
		<label>Verified</label>
		<select name="verified">
			<option value="0" {if $account->verified==0}selected="selected"{/if}>No</option>
			<option value="1" {if $account->verified==1}selected="selected"{/if}>Yes</option>
		</select>
	</div>
	
	<div class="form_70">
		<label>Detail</label><input type="text" name="description" value="{$account->description}">
	</div>
	
	<div class="form_30">
		<label>Hide</label>
		<select name="hide">
			<option value="0" {if $account->hide==0}selected="selected"{/if}>No</option>
			<option value="1" {if $account->hide==1}selected="selected"{/if}>Yes</option>
		</select>
	</div>

	<input type="hidden" name="account_id" value="{$account->id()|default:'0'}">
</form>
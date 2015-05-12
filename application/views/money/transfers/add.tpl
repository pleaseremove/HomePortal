<form action="money/transfers/save">

	<div class="form_30"><label>Date</label><input type="text" name="date" value="{$smarty.now|date_format:'%Y-%m-%d'}" class="date_picker"></div>
	<div class="form_30">
		<label>Account From</label>
		<select name="account_id_from">
			{foreach from=$accounts item=a}
				<option value="{$a->id()}" {if isset($item->account_id) && $item->account_id==$a->id()} selected="selected"{/if}>{$a->name}</option>
			{/foreach}
		</select>
	</div>
	<div class="form_30">
		<label>Account To</label>
		<select name="account_id_to">
			{foreach from=$accounts item=a}
				<option value="{$a->id()}" {if isset($item->account_id) && $item->account_id==$a->id()} selected="selected"{/if}>{$a->name}</option>
			{/foreach}
		</select>
	</div>
	
	<div class="form_100">
		<label>Description</label>
		<textarea style="height:75px;" name="description"></textarea>
	</div>
	
	<div class="form_30">
		<label>Amount</label>
		<input name="amount" value="" />
	</div>
</form>
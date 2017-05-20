<form method="post" action="/mobile/money/save_transfer">

		<div data-role="fieldcontain">
			<label for="date">Date:</label>
			<input type="date" name="date" id="date" value="{$smarty.now|date_format:'%Y-%m-%d'}" />
		</div>

		<div data-role="fieldcontain">
			<label for="account_id_from" class="select">From Account:</label>
			<select name="account_id_from" id="account_id_from">
				{foreach from=$accounts item=a}
					<option value="{$a->id()}">{$a->name}</option>
				{/foreach}
			</select>
		</div>

		<div data-role="fieldcontain">
			<label for="account_id_to" class="select">To Account:</label>
			<select name="account_id_to" id="account_id_to">
				{foreach from=$accounts item=a}
					<option value="{$a->id()}">{$a->name}</option>
				{/foreach}
			</select>
		</div>

		<div data-role="fieldcontain">
			<label for="amount">Amount:</label>
			<input type="tel" name="amount" id="amount" autocomplete="off" value="" />
		</div>

		<div data-role="fieldcontain">
			<label for="name">Description:</label>
			<textarea name="description" id="description" autocomplete="off"></textarea>
		</div>

		<input type="submit" value="Save" />
	</form>
</div>

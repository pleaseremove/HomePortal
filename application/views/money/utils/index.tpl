<div id="title_bar" class="box_background border_color_bottom">
	<h2>Money Utilities</h2>
</div>

<div id="content">
	<p style="margin: 10px 2%;">
		<a data-selection="money-utils" href="money/utils/forward_planning">Forward Planning</a>
	</p>
	
	<form action="money/import/ofx" method="post">
		<select name="account_id">
			{foreach from=$accounts item=a}
				<option value="{$a->id()}">{$a->name}</option>
			{/foreach}
		</select>
		<input type="file" name="import_file" />
		<input type="submit" value="Upload" />
	</form>
	
</div>
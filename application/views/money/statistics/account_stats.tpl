<div id="title_bar" class="box_background border_color_bottom">
	<h2>Account Statistics</h2>
</div>

<div id="content">
	<form action="money/statistics/account_breakdown">
		<p style="margin: 10px 2%;">
			<label>Account</label>
			<select name="account_id">
				<option value="0">Combined</option>
				{foreach from=$accounts item=a}
					<option value="{$a->id()}" {if $a->id()==$smarty.post.account_id}selected="selected"{/if}>{$a->name}</option>
				{/foreach}
			</select>
			<input type="submit" value="Update" />
		</p>
	</form>

	{include file="money/statistics/total_balance.tpl"}
	
	{include file="money/statistics/category_distribution_widget.tpl"}
</div>

<script src="_js/widgets.js" type="text/javascript"></script>
<form action="money/categories/save">
	<div class="form_100"><label>Name</label><input type="text" name="description" value="{$category->description}"></div>
	<div class="form_50">
		<label style="width:105px;">Target Amount (&pound;)</label>
		<input type="text" name="target_amount" value="{$category->target_amount|default:'0'}" />
	</div>
	<div class="form_50">
		<label style="width:105px;">Color (HEX)</label>
		<input type="text" name="color" value="{$category->color|default:'#'}" />
	</div>
	<input type="hidden" name="money_category_id" value="{$category->id()|default:'0'}">
</form>
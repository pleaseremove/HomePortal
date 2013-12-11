<form action="money/categories/save">
	<div class="form_100"><label>Name</label><input type="text" name="description" value="{$category->description}"></div>
	<div class="form_50">
		<label>Parent</label>
		<select name="parent">
			{foreach from=$categories item=c}
        <option {if isset($category->parent) && $category->parent==$c->id()}selected="selected" {/if}label="{$c->description}" value="{$c->id}">{$c->description}</option>
			{/foreach}
		</select>
	</div>
	<div class="form_50">
		<label style="width:105px;">Include in reports</label>
		<select name="dont_include_in_stats">
			<option {if isset($category->dont_include_in_stats) && $category->dont_include_in_stats==0}selected="selected" {/if}label="Yes" value="0">Yes</option>
      <option {if isset($category->dont_include_in_stats) && $category->dont_include_in_stats==1}selected="selected" {/if}label="No" value="1">No</option>
		</select>
	</div>
	<div class="form_50">
		<label style="width:105px;">New Parent</label>
		<input type="text" name="new_parent" value="" />
	</div>
	<div class="form_50">
		<label style="width:105px;">New Parent Color</label>
		<input type="text" name="new_parent_color" value="" />
	</div>
	<input type="hidden" name="money_category_id" value="{$category->id()|default:'0'}">
</form>
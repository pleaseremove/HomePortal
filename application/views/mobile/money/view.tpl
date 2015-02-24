<form method="post" action="/mobile/money/save">

		<div data-role="fieldcontain">
			<label for="date">Date:</label>
			<input type="date" name="date" id="date" value="{$t->date|default:$smarty.now|date_format:'%Y-%m-%d'}" />
		</div>
		
		<div data-role="fieldcontain">
			<label for="trans_type" class="select">Type:</label>
			<select name="trans_type" id="trans_type">
				<option value="-1" {if isset($t->trans_type) && $t->trans_type==-1} selected="selected"{/if}>Debit</option>
				<option value="1" {if isset($t->trans_type) && $t->trans_type==1} selected="selected"{/if}>Credit</option>
			</select>
		</div>
		
		<div data-role="fieldcontain">
			<label for="account_id" class="select">Account:</label>
			<select name="account_id" id="account_id">
				{foreach from=$accounts item=a}
					<option value="{$a->id()}" {if isset($t->account_id) && $t->account_id==$a->id()} selected="selected"{/if}>{$a->name}</option>
				{/foreach}
			</select>
		</div>
		
		<div id="repeat_space">
		
			<div class="ui-corner-all clone_area" style="margin-bottom:10px;">
			  <div class="ui-bar ui-bar-a">
			    <h3>Item <span>1</span></h3>
			  </div>
			  <div class="ui-body ui-body-a">
			    <div data-role="fieldcontain">
						<label for="catagory_id" class="select">Category:</label>
						<select name="catagory_id[]" id="catagory_id">
							{foreach from=$categories name=category item=c}
								{if $group != $c->parent}
			            {if !$smarty.foreach.category.first}</optgroup>{/if}
			            {assign var='group' value=$c->parent}
			            <optgroup label="{$group}">
			          {/if}
			          <option label="{$c->description}" value="{$c->id}" {if isset($t->category_id) && $t->category_id==$c->id} selected="selected"{/if}>{$c->description}</option>
			          {if $smarty.foreach.category.last}</optgroup>{/if}
							{/foreach}
						</select>
					</div>
					
					<div data-role="fieldcontain">
						<label for="amount">Amount:</label>
						<input type="text" name="amount[]" id="amount" autocomplete="off" value="{$t->amount}" />
					</div>
					
			  </div>
			</div>
		
		</div>
	
		<button id="add_item" class="ui-btn ui-btn-inline ui-icon-plus ui-btn-icon-right">Add Item</button>
		
		<div data-role="fieldcontain">
			<label for="name">Description:</label>
			<textarea name="description" id="description" autocomplete="off">{$t->description}</textarea>
		</div>
		
		<input type="hidden" value="{$t->id()}" name="trans_id" />
		<input type="submit" value="Save" />
	</form>
</div>

<script type="text/javascript">

var clone_data = '<div class="ui-field-contain" data-role="fieldcontain"><label for="catagory_id" class="select">Category:</label><select name="catagory_id[]" id="catagory_id">{foreach from=$categories name=category item=c}{if $group != $c->parent}{if !$smarty.foreach.category.first}</optgroup>{/if}{assign var="group" value=$c->parent}<optgroup label="{$group}">{/if}<option label="{$c->description}" value="{$c->id}" {if isset($t->category_id) && $t->category_id==$c->id} selected="selected"{/if}>{$c->description}</option>{if $smarty.foreach.category.last}</optgroup>{/if}{/foreach}</select></div><div class="ui-field-contain" data-role="fieldcontain"><label for="amount">Amount:</label><div class="ui-input-text ui-body-inherit ui-corner-all ui-shadow-inset"><input type="number" name="amount[]" id="amount" autocomplete="off" value="{$t->amount}" /></div></div>';

$(function(){
	$('#add_item').bind('click',function(e){
		e.preventDefault();
		
		var $repeat_block = $('.clone_area:first').clone();
		$repeat_block.find('select option').removeAttr('selected');
		$repeat_block.find('input,select').val('');
		
		$repeat_block.find('.ui-bar span').text($('.clone_area').size()+1);
		
		$repeat_block.find('.ui-body').html(clone_data);
		
		$repeat_block.find('select').selectmenu();
		
		$('#repeat_space').append($repeat_block);
	});
});
</script>
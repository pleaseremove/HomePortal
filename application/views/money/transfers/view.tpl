<form action="money/transactions/save">

	<div class="form_30"><label>Date</label><input type="text" name="date" value="{$item->date|default:$smarty.now|date_format:'%Y-%m-%d'}" class="date_picker"></div>
	<div class="form_30">
		<label>Account</label>
		<select name="account_id">
			{foreach from=$accounts item=a}
				<option value="{$a->id()}" {if isset($item->account_id) && $item->account_id==$a->id()} selected="selected"{/if}>{$a->name}</option>
			{/foreach}
		</select>
	</div>
	<div class="form_30">
		<label>Type</label>
		<select name="trans_type">
			<option value="-1" {if isset($item->trans_type) && $item->trans_type==-1} selected="selected"{/if}>Debit</option>
			<option value="1" {if isset($item->trans_type) && $item->trans_type==1} selected="selected"{/if}>Credit</option>
		</select>
	</div>
	
	<div class="form_100">
		<textarea style="height:90px;margin-top:10px;" name="description">{$item->description|replace:'\n':"\n"}</textarea>
	</div>
	
	<div class="form_100">
		Total: &pound <span id="amount_total">0.00</span>
	</div>
	
	<div class="repeat">
		{if $item->isNew()}
			<div class="repeat_content">
				<div class="form_50">
					<label>Category</label>
					<select name="catagory_id[]">
						{foreach from=$categories name=category item=c}
							{if $group != $c->parent}
		            {if !$smarty.foreach.category.first}</optgroup>{/if}
		            {assign var='group' value=$c->parent}
		            <optgroup label="{$group}">
		          {/if}
		          <option label="{$c->description}" value="{$c->id}">{$c->description}</option>
		          {if $smarty.foreach.category.last}</optgroup>{/if}
						{/foreach}
					</select>
				</div>
				
				<div class="form_30">
					<label>Amount</label>
					<input name="amount[]" value="" />
				</div>
			</div>
		{else}
			{foreach from=$item->transactions() item=t}
				<div class="repeat_content">
					<div class="form_50">
						<label>Category</label>
						<select name="catagory_id[]">
							{foreach from=$categories name=category item=c}
								{if $group != $c->parent}
			            {if !$smarty.foreach.category.first}</optgroup>{/if}
			            {assign var='group' value=$c->parent}
			            <optgroup label="{$group}">
			          {/if}
			          <option label="{$c->description}" {if isset($t->category_id) && $t->category_id==$c->id} selected="selected"{/if} value="{$c->id}">{$c->description}</option>
			          {if $smarty.foreach.category.last}</optgroup>{/if}
							{/foreach}
						</select>
					</div>
					
					<div class="form_30">
						<label>Amount</label>
						<input name="amount[]" value="{$t->amount}" />
					</div>
				</div>
			{/foreach}
		{/if}
	</div>
	
	<span id="add_item" style="background: url('_images/icons/add.png') no-repeat scroll 0 0 transparent;display:block;height:24px;position:absolute;right:80px;top:203px;width:24px;cursor:pointer;"></span>

	<input type="hidden" name="item_id" value="{$item->id()|default:'0'}">
	<script type="text/javascript">
	$(function() {
		$('#add_item').bind('click',function(){
			var $repeat_block = $('.repeat_content:first').clone();
			$repeat_block.find('select option').removeAttr('selected');
			$repeat_block.find('input').val('');
			$('.repeat').append($repeat_block);
		});
		
		$(document).on('keyup','.repeat_content input',function(){
			update_total();
		});
		
		update_total();
		
	});
	
	function update_total(){
		var running_total = 0;
		$('.repeat_content input').each(function(){
			running_total = running_total+parseFloat(($(this).val()!='' ? $(this).val() : 0 ));
		});
		$('#amount_total').text(running_total.toFixed(2));
	}
	</script>
</form>
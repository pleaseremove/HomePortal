<form action="contacts/save" method="post" enctype="multipart/form-data">
	<div class="contact_view tabs_box">
		<ul>
			<li class="c-overview active" data-tab="c-overview">Main Details</li>
			<li class="c-details" data-tab="c-details">Contact Information</li>
			<li class="c-emails" data-tab="c-emails">E-mails</li>
			<li class="c-addresses" data-tab="c-addresses">Addresses</li>
			<li class="c-family" data-tab="c-family">Family</li>
		</ul>
		<div class="tab c-overview">
			<div class="form_50"><label>First Name</label><input type="text" name="first_name" value="{$contact->first_name}"></div>
			<div class="form_50"><label>Last Name</label><input type="text" name="last_name" value="{$contact->last_name}"></div>
			
			<div class="form_30">
				<label>Title</label>
				<select name="title_id">
					<option value="0"></option>
					{foreach from=$contact_titles item=t}
						<option value="{$t->id()}" {if isset($contact->title_id) && $contact->title_id==$t->id()}selected="selected"{/if}>{$t->title}</option>
					{/foreach}
				</select>
			</div>
			<div class="form_30"><label>Other Names</label><input type="text" name="other_names" value="{$contact->other_names}"></div>
			<div class="form_30">
				<label>Gender</label>
				<select name="gender">
					<option value="0" {if isset($contact->gender) && $contact->gender==0}selected="selected"{/if}>Female</option>
					<option value="1" {if isset($contact->gender) && $contact->gender==1}selected="selected"{/if}>Male</option>
				</select>
			</div>
			
			<div class="form_30"><label>Birthday</label><input type="text" name="birthday" value="{$contact->birthday|date_format:'%Y-%m-%d'}" class="date_picker"></div>
			<div class="form_30"><label>Aniversary</label><input type="text" name="aniversary" value="{$contact->aniversary|date_format:'%Y-%m-%d'}" class="date_picker"></div>
			<div class="form_30">
				<label>Private</label>
				<select name="private">
					<option value="0" {if isset($contact->private) && $contact->private==0}selected="selected"{/if}>No</option>
					<option value="1" {if isset($contact->private) && $contact->private==1}selected="selected"{/if}>Yes</option>
				</select>
			</div>
			
			<div class="form_30">
				<label>Groups</label>
				<ul class="multiselect" style="height:100px;overflow-y:scroll;width:100%;">
				{foreach from=$groups item=g}
					<li><input type="checkbox" name="groups[{$g->id()}]" {if in_array($g->id(),$contact->cats_selected())}checked="checked"{/if} /><label for="groups[{$g->id()}]">{$g->description}<label></li>
				{/foreach}
				</ul>
			</div>
			
			<div class="form_30">
				<label>Current Image</label>
				<div class="img_holder" style="width:81px;">
					<div class="img_holder2" style="background-image: url('_images/contact_photos/{$contact->picture|default:'default_image.png'}')"></div>
				</div>
			</div>
			
			<div class="form_30">
				<label>New Image</label>
				<input type="file" name="contact_photo" />
			</div>
			
			<div class="form_100">
				<label>Notes</label>
				<textarea style="height:200px;" name="notes">{$contact->notes|replace:'\n':"\n"}</textarea>
			</div>
	
		</div>
		
		<div class="tab c-details">
			<div class="repeat">
			{if $contact->isNew() || count($contact->data()) == 0}
				<div class="repeat_content">
					<div class="form_30">
						<label>Data Type</label>
						<select name="data_types[]">
							{foreach from=$data_types item=dt name=data_loop}
								{if $smarty.foreach.data_loop.first}
									{assign var='data_first' value=$dt->id()}
								{/if}
			          <option label="{$dt->data_type_name}" type="text" value="{$dt->id()}">{$dt->data_type_name}</option>
							{/foreach}
						</select>
					</div>
					
					<div class="form_50">
						<label>Value</label>
						<input name="data_type_value[]" value="" style="float:left;width:80%;" />
						<input name="data_type_in_use[0]" type="checkbox" style="float:left;height:29px;width:10%;" />
						<input name="data_type_default[{$data_first}]" value="0" type="radio" style="float:left;height:29px;width:6%;" />
					</div>
				</div>
			{else}
				{foreach from=$contact->data() item=cd name=cd_loop}
					<div class="repeat_content">
						<div class="form_30">
							<label>Data Type</label>
							<select name="data_types[]">
								{foreach from=$data_types item=dt}
				          <option label="{$dt->data_type_name}" value="{$dt->id()}" {if isset($cd->contact_data_type) && $cd->contact_data_type==$dt->id()}selected="selected"{/if}>{$dt->data_type_name}</option>
								{/foreach}
							</select>
						</div>
						
						<div class="form_50">
							<label>Value</label>
							<input name="data_type_value[]" type="text" value="{$cd->data}" style="float:left;width:80%;" />
							<input name="data_type_in_use[{$smarty.foreach.cd_loop.index}]" type="checkbox" {if $cd->in_use==1}checked="checked"{/if} style="float:left;height:29px;width:10%;" />
							<input name="data_type_default[{$cd->contact_data_type}]" value="{$smarty.foreach.cd_loop.index}" {if $cd->default==1}checked="checked"{/if} type="radio" style="float:left;height:29px;width:6%;" />
						</div>
					</div>
				{/foreach}
			{/if}
		</div>
		
		<span class="add_item" data-where=".c-details .repeat" style="background: url('_images/icons/add.png') no-repeat scroll 0 0 transparent;display:block;height:24px;position:absolute;right:30px;top:75px;width:24px;cursor:pointer;"></span>
		
		</div>
		
		<div class="tab c-emails">
			<div class="repeat">
			{if $contact->isNew() || count($contact->emails()) == 0}
				<div class="repeat_content">
					<div class="form_70">
						<label>E-mail</label>
						<input name="email_value[]" value="" style="float:left;width:80%;" />
						<input name="email_in_use[0]" type="checkbox" style="float:left;height:29px;width:10%;" />
						<input name="email_value_default" value="0" type="radio" style="float:left;height:29px;width:5%;" />
					</div>
				</div>
			{else}
				{foreach from=$contact->emails() item=em name=em_loop}
					<div class="repeat_content">
						<div class="form_70">
							<label>E-mail</label>
							<input name="email_value[]" type="text" value="{$em->email}" style="float:left;width:80%;" />
							<input name="email_in_use[{$smarty.foreach.em_loop.index}]" type="checkbox" {if $em->in_use==1}checked="checked"{/if} style="float:left;height:29px;width:10%;" />
							<input name="email_value_default" value="{$smarty.foreach.em_loop.index}" {if $em->default==1}checked="checked"{/if} type="radio" style="float:left;height:29px;width:5%;" />
						</div>
					</div>
				{/foreach}
			{/if}
			</div>
			
			<span class="add_item" data-where=".c-emails .repeat" style="background: url('_images/icons/add.png') no-repeat scroll 0 0 transparent;display:block;height:24px;position:absolute;right:30px;top:75px;width:24px;cursor:pointer;"></span>
		</div>
		
		<div class="tab c-addresses">
			<div class="repeat">
			{if $contact->isNew() || count($contact->addresses()) == 0}
				<div class="repeat_content" style="display:inline-block;width:49%;">
					<div class="form_70">
						<label>Name</label>
						<input name="address_name[]" value="" />
						<label>Building</label>
						<input name="address_building[]" value="" />
						<label>House</label>
						<input name="address_house[]" value="" />
						<label>Road</label>
						<input name="address_road[]" value="" />
						<label>Locality</label>
						<input name="address_locality[]" value="" />
						<label>Town</label>
						<input name="address_town[]" value="" />
						<label>County</label>
						<input name="address_county[]" value="" />
						<label>PostCode</label>
						<input name="address_postcode[]" value="" />
						<label>Country</label>
						<input name="address_country[]" value="" />
						<input name="address_default" type="radio" value="0" />
					</div>
				</div>
			{else}
				{foreach from=$contact->addresses() item=ad name=ad_loop}
					<div class="repeat_content" style="display:inline-block;width:49%;">
						<div class="form_70">
							<label>Name</label>
							<input name="address_name[]" value="{$ad->name}" />
							<label>Building</label>
							<input name="address_building[]" value="{$ad->building}" />
							<label>House</label>
							<input name="address_house[]" value="{$ad->house}" />
							<label>Road</label>
							<input name="address_road[]" value="{$ad->road}" />
							<label>Locality</label>
							<input name="address_locality[]" value="{$ad->locality}" />
							<label>Town</label>
							<input name="address_town[]" value="{$ad->town}" />
							<label>County</label>
							<input name="address_county[]" value="{$ad->county}" />
							<label>PostCode</label>
							<input name="address_postcode[]" value="{$ad->postcode}" />
							<label>Country</label>
							<input name="address_country[]" value="{$ad->country}" />
							<input name="address_default" type="radio" value="{$smarty.foreach.ad_loop.index}" {if $ad->main==1}checked="checked"{/if} />
						</div>
					</div>
				{/foreach}
			{/if}
			</div>
			
			<span class="add_item" data-where=".c-addresses .repeat" style="background: url('_images/icons/add.png') no-repeat scroll 0 0 transparent;display:block;height:24px;position:absolute;right:30px;top:75px;width:24px;cursor:pointer;"></span>
		</div>
		
		<div class="tab c-family">
			<h2>Related Contacts</h2>
			<div class="repeat rels">
			{if $contact->isNew() || count($contact->related()) == 0}
				<div class="repeat_content">
					<div class="form_70">
						<label>Relation</label>
						<select name="related_contact[]">
							<option value="0"></option>
							{foreach from=$contacts item=c}
								<option value="{$c->id()}">{$c->first_name|capitalize} {$c->last_name|capitalize}</option>
							{/foreach}
						</select>
					</div>
				</div>
			{else}
				{foreach from=$contact->related() item=rl}
					<div class="repeat_content">
					<div class="form_70">
						<label>Relation</label>
						<select name="related_contact[]">
							<option value="0"></option>
							{foreach from=$contacts item=c}
								{if $c->id() != $contact->id()}
									<option value="{$c->id()}" {if $rl->contact_id==$c->id()} selected="selected"{/if}>{$c->first_name|capitalize} {$c->last_name|capitalize}</option>
								{/if}
							{/foreach}
						</select>
					</div>
				</div>
				{/foreach}
			{/if}
			</div>
			
			<span class="add_item" data-where=".c-family .repeat.rels" style="background: url('_images/icons/add.png') no-repeat scroll 0 0 transparent;display:block;height:24px;position:absolute;right:30px;top:75px;width:24px;cursor:pointer;"></span>
		</div>
		
	</div>
	<script type="text/javascript">
		$(function(){
			$('.add_item').bind('click',function(){
				var location_selector = $(this).attr('data-where');
				var $repeat_block = $(location_selector+' .repeat_content:first').clone();
				$repeat_block.find('select option').removeAttr('selected');
				$repeat_block.find('input').val('');
				$repeat_block.find('input[type=radio], input[type=checkbox]').removeAttr('checked');
				if(location_selector=='.c-details .repeat'){
					update_group_id($repeat_block.find('select'));
					$repeat_block.find('select').on('change',function(){
						update_group_id($(this));
					});
					number_blocks('.c-details');
				}
				$(location_selector).append($repeat_block);
				if(location_selector=='.c-details .repeat'){
					number_blocks('.c-details');
				}
				if(location_selector=='.c-emails .repeat'){
					number_blocks('.c-emails');
				}
				if(location_selector=='.c-addresses .repeat'){
					number_blocks('.c-addresses');
				}
			});
		});
		
		$('.c-details .repeat_content select').each(function(){
			update_group_id($(this));
			$(this).on('change',function(){
				update_group_id($(this));
			});
		});
		
		function update_group_id($element){
			$element.parent().parent().find('input[type=radio]').attr('name','data_type_default['+$element.val()+']');
		}
		
		function number_blocks(selector){
			$(selector+' .repeat_content').each(function(index){
				$(this).find('input[type=checkbox]').each(function(){
        	this.name = this.name.replace(/\[\d+\]/, "[" + index + "]");   
        });
	      $(this).find('input[type=radio]').each(function(){
	      	$(this).val(index);
	      });
			});
		}
	</script>
	<input type="hidden" name="contact_id" value="{$contact->id()|default:'0'}">
</form>
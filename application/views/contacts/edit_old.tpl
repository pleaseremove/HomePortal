<div class="contact_view tabs_box box_background border_color_bottom">
	<ul class="border_color_bottom box_shadow">
		<li class="c-overview active" data-tab="c-overview">Overview</li>
		<li class="c-details" data-tab="c-details">Contact Details</li>
		<li class="c-addresses" data-tab="c-addresses">Addresses</li>
		<li class="c-notes" data-tab="c-notes">Notes</li>
	</ul>
	<div class="tab c-overview">
		<div class="left_form">
			<p class="form_line">
				<label>First Name:</label><input name="first_name" value="{$contact->first_name}" />
			</p>
			<p class="form_line">
				<label>Other Names:</label><input name="other_names" value="{$contact->other_names}" />
			</p>
			<p class="form_line">
				<label>Last Name:</label><input name="last_name" value="{$contact->last_name}" />
			</p>
			<p class="form_line">
				<label>Birthday:</label><input class="date_picker" name="birthday" value="{$contact->birthday}" />
			</p>
			<p class="form_line">
				<label>Aniversary:</label><input class="date_picker" name="aniversary" value="{$contact->aniversary}" />
			</p>
			<p class="form_line">
				<label>Private:</label><input type="checkbox" name="private" {if $contact->private==1}checked="checked" {/if}value="1" />
			</p>
		</div>
	</div>
	<div class="tab c-details">
		<div class="left_form">
			<h2>E-mails</h2>
			{foreach from=$contact->emails() item=e name=cemails}
				<p class="form_line">
					<label>Email {$smarty.foreach.cemails.index+1}:</label><input name="emails[{$e->id()}]" type="text" value="{$e->email}" />
					<input type="radio" name="main_email" value="{$e->id()}"{if $e->default==1} checked="checked"{/if} />
				</p>
			{/foreach}
		</div>
	</div>
	<div class="tab c-addresses">
		{foreach from=$contact->addresses() item=a}
			<div class="c-address">
				<p class="form_line">
					<label>Name:</label><input name="address[$a->id()][name]" value="{$a->name}" />
				</p>
				<p class="form_line">
					<label>House:</label><input name="address[$a->id()][house]" value="{$a->house}" />
				</p>
				<p class="form_line">
					<label>Road:</label><input name="address[$a->id()][road]" value="{$a->road}" />
				</p>
				<p class="form_line">
					<label>Town/City:</label><input name="address[$a->id()][town]" value="{$a->town}" />
				</p>
				<p class="form_line">
					<label>County:</label><input name="address[$a->id()][county]" value="{$a->county}" />
				</p>
				<p class="form_line">
					<label>Postcode:</label><input name="address[$a->id()][postcode]" value="{$a->postcode}" />
				</p>
				<p class="form_line">
					<label>Country:</label><input name="address[$a->id()][country]" value="{$a->country}" />
				</p>
				<p class="form_line">
					<label>Main Address:</label><input type="radio" name="main_address" value="{$a->id}"{if $a->main==1} checked="checked"{/if} />
				</p>
			</div>
		{/foreach}
	</div>
	<div class="tab c-notes">
		<textarea>{$contact->notes}</textarea>
	</div>
</div>
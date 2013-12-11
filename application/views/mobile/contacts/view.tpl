<h2>Overview</h2>
<div class="ui-grid-a">
	<div class="ui-block-a">First Name: </div>
	<div class="ui-block-b">{$contact->first_name|capitalize}</div>
	
	<div class="ui-block-a">Other Names: </div>
	<div class="ui-block-b">{$contact->other_names|capitalize}</div>
	
	<div class="ui-block-a">Last Name: </div>
	<div class="ui-block-b">{$contact->last_name|capitalize}</div>
	
	<div class="ui-block-a">Birthday: </div>
	<div class="ui-block-b">{$contact->birthday|date_format}</div>
	
	<div class="ui-block-a">Aniversary: </div>
	<div class="ui-block-b">{$contact->aniversary|date_format}</div>
</div>

<h2>Contact Details</h2>
<div class="ui-grid-a">
	{foreach from=$contact->data() item=d}
		<div class="ui-block-a">{$d->data_type_name}</div>
		<div class="ui-block-b">{$d->data_type_view_string|replace:'<%data%>':$d->data}</div>
	{/foreach}
</div>

<h2>E-mails</h2>
<div class="ui-grid-a">
	{foreach from=$contact->emails() item=e name=cemails}
		<div class="ui-block-a">Email {$smarty.foreach.cemails.index+1}</div>
		<div class="ui-block-b">{$e->email}</div>
	{/foreach}
</div>

<h2>Addresses</h2>
<div class="ui-grid-a">
	{foreach from=$contact->addresses() item=a}
		<div style="margin-bottom:10px;">
			<div>{$a->name}</div>
			<div>
				{$a->house}{if isset($a->house)}<br />{/if}
				{$a->road}{if isset($a->road)}<br />{/if}
				{$a->town}{if isset($a->town)}<br />{/if}
				{$a->county}{if isset($a->county)}<br />{/if}
				{$a->postcode}{if isset($a->postcode)}<br />{/if}
				{$a->country}{if isset($a->country)}<br />{/if}
			</div>
		</div>
	{/foreach}
</div>

<h2>Notes</h2>
{$contact->notes|nl2br}
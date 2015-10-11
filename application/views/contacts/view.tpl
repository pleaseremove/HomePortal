<div id="title_bar" class="box_background border_color_bottom">
	<h2>Contact: {$contact->first_name|capitalize} {$contact->last_name|capitalize}</h2>
	<div id="titlebar_right">
		<a href="contacts/edit/{$contact->id()}" data-width="800" data-height="650" data-title="Contact Edit: {$contact->first_name|capitalize} {$contact->last_name|capitalize}" data-menu-click="contacts" data-selection="contacts" class="model inline_button">Edit</a>
	</div>
</div>

<div id="content">
	<div class="contact_view">
	
		<div class="widget full">
			<div class="widget_title">Overview</div>
			<div class="c-overview widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
				
				<div class="content_left" style="padding:5px;">
					<div class="img_holder">
						<div class="img_holder2" style="background-image: url('_images/contact_photos/{$contact->picture|default:'default_image.png'}')"></div>
					</div>
				</div>
				
				<div class="content_left" style="padding:5px;width:35%">
					<p class="person">
						<span>{$contact->first_name|capitalize}{if isset($contact->other_names)} {$contact->other_names|capitalize}{/if} {$contact->last_name|capitalize}</span>
					</p>
					<p class="gender {if isset($contact->gender)}{if $contact->gender==1}male{else}female{/if}{else}unknown{/if}">
						<span>{if isset($contact->gender)}{if $contact->gender==1}Male{else}Female{/if}{else}Unknown{/if}</span>
					</p>
				</div>
				
				<div class="content_left" style="padding:5px;width:22%">
					{if isset($contact->birthday)}
					<p class="birthday">
						<span>{$contact->birthday|date_format} ({$contact->age()})</span>
					</p>
					{/if}
					{if isset($contact->aniversary)}
					<p class="aniversary">
						<span>{$contact->aniversary|date_format} ({$contact->aniversary()})</span>
					</p>
					{/if}
				</div>
				
				<div class="content_left" style="padding:5px;width:25%">
					{foreach from=$contact->categories() item=cc}
						<p class="category">
							<span>{$cc->description}</span>
						</p>
					{/foreach}
				</div>
				
				<div style="clear:both"></div>
				
			</div>
		</div><!-- .widget -->
	
		<div class="widget" style="width:26%">
			<div class="widget_title">Family</div>
			<div class="c-overview widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
					
				{foreach from=$contact->related() item=cr name=contact_r}
					{if $smarty.foreach.contact_r.first}
						<h3>Relations</h3>
					{/if}
					<p class="relation">
						<a href="contacts/view/{$cr->id()}">{$cr->first_name|capitalize} {$cr->last_name|capitalize}</a>
					</p>
				{/foreach}
				
				{foreach from=$contact->children() item=cc name=contact_c}
					{if $smarty.foreach.contact_c.first}
						<br />
						<h3>Children</h3>
					{/if}
					<p class="child" title="{date('M jS',strtotime($cc->birthday))} ({$cc->age()})">
						{$cc->name|capitalize} {if isset($cc->birthday)}{/if}
					</p>
				{/foreach}
				
			</div>
		</div><!-- .widget -->
		
		<div class="widget" style="width:65%">
			<div class="widget_title">Contact Details</div>
			<div class="c-details widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
				{foreach from=$contact->data() item=d}
					<p class="contact_{$d->data_type_id} {if $d->in_use==0}strike{/if} {if $d->default==1}default{/if}" title="{$d->data_type_name}">
						<span>{$d->data_type_view_string|replace:'<%data%>':$d->data}</span>
					</p>
				{/foreach}

				{foreach from=$contact->emails() item=e name=cemails}
					<p class="contact_emails {if $e->in_use==0}strike{/if} {if $e->default==1}default{/if}">
						<span><a class="click-through" href="mailto:{$e->email}">{$e->email}</a></span>
					</p>
				{/foreach}
			</div>
		</div><!-- .widget -->
		
		{assign var='contact_a' value=$contact->addresses()}
		
		{if $contact_a->num_rows()>0}
		<div class="widget full">
			<div class="widget_title">Addresses</div>
			<div class="c-addresses widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
				{foreach from=$contact_a item=a}
					<div class="widget c-address">
						<div class="widget_title">{$a->name}</div>
						<div class="{if $a->main==1}main{/if} widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
							<p>{if isset($a->building)}{$a->building}, {/if}{$a->house}</p>
							<p>{$a->road}</p>
							<p>{$a->town}</p>
							<p>{$a->county}</p>
							<p>{$a->postcode}</p>
							<p>{$a->country}</p>
						</div>
					</div>
					{if $a->main==1}
						{assign var='main_address' value=$a->rowArray()}
					{/if}
				{/foreach}
				<div style="clear:left;"></div>
			</div>
		</div><!-- .widget -->
		{/if}
		
		{if isset($contact->notes) && $contact->notes!=''}
		<div class="widget full">
			<div class="widget_title">Notes</div>
			<div class="c-notes widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
				{$contact->notes|nl2br}
			</div>
		</div><!-- .widget -->
		{/if}
		
		{if isset($main_address)}
		<div class="widget full">
			<div class="widget_title">Maps
			{if $contact_a->num_rows()>1} - 
				<select id="map_selector">
					{foreach from=$contact_a item=a}
						<option {if $a->main==1}selected="selected"{/if} value="{if isset($a->building)}{$a->building}, {/if}{if isset($a->house)}{$a->house}, {/if}{if isset($a->road)}{$a->road}, {/if}{if isset($a->town)}{$a->town}, {/if}{if isset($a->county)}{$a->county}, {/if}{if isset($a->postcode)}{$a->postcode}, {/if}{if isset($a->country)}{$a->country}, {/if}">{$a->name}</option>
					{/foreach}
				</select>
			{/if}
			</div>
			<div class="c-maps widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
				<input type="hidden" id="main_address" value="{if isset($main_address.house)}{$main_address.house} {/if}{if isset($main_address.road)}{$main_address.road} {/if}{if isset($main_address.town)}{$main_address.town} {/if}{if isset($main_address.county)}{$main_address.county} {/if}{if isset($main_address.postcode)}{$main_address.postcode} {/if}{if isset($main_address.country)}{$main_address.country} {/if}" />
				<div style="width:100%;height:350px;" id="map_canvas">
				<script type="text/javascript">
					{literal}
					var geocoder;
				  var map;
				  function initialize() {
				    geocoder = new google.maps.Geocoder();
				    
				    var address = document.getElementById('main_address').value;
				    
				    geocoder.geocode( { 'address': address}, function(results, status) {
				    
				      if (status == google.maps.GeocoderStatus.OK) {
				        
				        //var latlng = new google.maps.LatLng(results[0].geometry.location);
						    var mapOptions = {
						      zoom: 16,
						      center: results[0].geometry.location,
						      mapTypeId: google.maps.MapTypeId.ROADMAP
						    }
						    
						    map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
				        
				        var marker = new google.maps.Marker({
				            map: map,
				            position: results[0].geometry.location
				        });
				      } else {
				        console.log('Failed because: '+status);
				      }
				    });
				    
				    if(document.getElementById('map_selector')!==null){
							google.maps.event.addDomListener(document.getElementById('map_selector'), 'change', function() {
						    if (this.value != "") {
						      codeAddress(this.value);
						    }
							});
						}
				  }
				  
				  function codeAddress(address){
					    geocoder.geocode( { 'address': address}, function(results, status) {
					        if (status == google.maps.GeocoderStatus.OK) {
					            map.setCenter(results[0].geometry.location);
					            var marker = new google.maps.Marker({ map: map, position: results[0].geometry.location });
					        } else {
					            alert("Geocode was not successful for the following reason: " + status);
					        }
					    });
					}
				  $(function(){
				  	initialize();
				  });
				{/literal}
				</script>
			</div>
		</div><!-- .widget -->
		</div><!-- .widget -->
		{/if}
		
		{assign var='contact_sms' value=$contact->sms()}
		
		{if $contact_sms->num_rows()>0}
		<div class="widget full">
			<div class="widget_title">Text Messages</div>
			<div class="c-sms widget_content box_background border_color_bottom border_color_top border_color_left border_color_right" style="overflow-x:scroll;height:350px;" id="sms_box">
				{foreach from=$contact_sms item=sms}
					<div class="sms {$sms->received_sent}">
						{$sms->message}
						<div class="datetime">{$sms->datetime|date_format:'%b %e, %Y @ %H:%M'}</div>
					</div>
				{/foreach}
				<div style="clear:left;"></div>
			</div>
		</div><!-- .widget -->
		<script type="text/javascript">
			var sms_box = document.getElementById('sms_box');
			sms_box.scrollTo(0,100000000);
		</script>
		{/if}
		
  </div>
</div>
<script src="_js/widgets.js" type="text/javascript"></script>

<style type="text/css">
	.sms{
		border: 1px solid #E3E3E3;
		border-radius: 3px;
		background-color: #fff;
		padding: 5px;
	}
	
	.sms.received {
    margin: 5px 50% 5px 0;
	}
	.sms.sent {
    margin: 5px 0 5px 50%;
	}
	.sms .datetime{
    color: #a2a2a2;
    text-align: right;
	}
</style>
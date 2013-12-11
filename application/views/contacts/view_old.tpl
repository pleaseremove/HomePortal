<div id="title_bar" class="box_background border_color_bottom">
	<h2>Contact: {$contact->first_name|capitalize} {$contact->last_name|capitalize}</h2>
	<div id="titlebar_right">
		<a href="contacts/edit/{$contact->id()}" data-title="Contact Edit: {$contact->first_name|capitalize} {$contact->last_name|capitalize}" data-menu-click="contacts" data-selection="contacts" class="model inline_button">Edit</a>
	</div>
</div>

<div id="content" class="spacing">
	<div class="contact_view tabs_box box_background border_color_bottom border_color_top border_color_left border_color_right">
		<ul class="border_color_bottom box_shadow">
			<li class="c-overview active" data-tab="c-overview">Overview</li>
			<li class="c-details" data-tab="c-details">Contact Details</li>
			<li class="c-addresses" data-tab="c-addresses">Addresses</li>
			<li class="c-maps" data-tab="c-maps">Maps</li>
			<li class="c-notes" data-tab="c-notes">Notes</li>
		</ul>
		<div class="tab c-overview">
			<div class="left_form">
				<p class="form_line">
					<label>First Name:</label><span>{$contact->first_name|capitalize}</span>
				</p>
				<p class="form_line">
					<label>Other Names:</label><span>{$contact->other_names|capitalize}</span>
				</p>
				<p class="form_line">
					<label>Last Name:</label><span>{$contact->last_name|capitalize}</span>
				</p>
				<p class="form_line">
					<label>Birthday:</label><span>{$contact->birthday|date_format}</span>
				</p>
				<p class="form_line">
					<label>Aniversary:</label><span>{$contact->aniversary|date_format}</span>
				</p>
				<img src="_images/contact_photos/{$contact->picture|default:'default_image.png'}" />
			</div>
		</div>
		<div class="tab c-details">
		
			<div class="right_form">
				{foreach from=$contact->data() item=d}
					<p class="form_line">
						<label>{$d->data_type_name}:</label><span>{$d->data_type_view_string|replace:'<%data%>':$d->data}</span>
					</p>
				{/foreach}
			</div>
		
			<div class="right_form">
				{foreach from=$contact->emails() item=e name=cemails}
					<p class="form_line">
						<label>Email {$smarty.foreach.cemails.index+1}:</label><span>{$e->email}</span>
					</p>
				{/foreach}
			</div>
			
		</div>
		<div class="tab c-addresses">
			{foreach from=$contact->addresses() item=a}
				<div class="widget c-address" style="width:180px;">
					<div class="widget_title">{$a->name}</div>
					<div class="{if $a->main==1}main{/if} widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
						<p>{$a->house}</p>
						<p>{$a->road}</p>
						<p>{$a->town}</p>
						<p>{$a->county}</p>
						<p>{$a->postcode}</p>
						<p>{$a->country}</p>
					</div>
				</div>
				{if $a->main==1}
					{assign var='main_address' value=$a}
				{/if}
			{/foreach}
		</div>
		<div class="tab c-maps">
			{*if isset($main_address)}
				<input type="hidden" id="main_address" value="{if isset($main_address->house)}{$main_address->house} {/if}{if isset($main_address->road)}{$main_address->road} {/if}{if isset($main_address->town)}{$main_address->town} {/if}{if isset($main_address->county)}{$main_address->county} {/if}{if isset($main_address->postcode)}{$main_address->postcode} {/if}{if isset($main_address->country)}{$main_address->country} {/if}" />
				<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
				<script type="text/javascript">
					{literal}
					var geocoder;
				  var map;
				  function initialize() {
				    geocoder = new google.maps.Geocoder();
				    
				    var address = document.getElementById('main_address').value;
				    
				    geocoder.geocode( { 'address': address}, function(results, status) {
				    
				      if (status == google.maps.GeocoderStatus.OK) {
				        
				        var latlng = new google.maps.LatLng(results[0].geometry.location);
						    var mapOptions = {
						      zoom: 8,
						      center: latlng,
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
				  }
					initialize();
				{/literal}
				</script>
			{/if*}
		</div>
		<div class="tab c-notes">
			{$contact->notes|nl2br}
		</div>
  </div>
</div>

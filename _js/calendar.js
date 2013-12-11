$(function() {
	var $my_cal = $('.calendar_grid').fullCalendar({
		dayClick: function(date, allDay, jsEvent, view){
			$.system.model_window('calendar/add','New event',650,500,function($form){
    		$.system.get_json($form.attr('action'),function(return_info){
    			if(return_info==true){
    				$form.parent().dialog("close");
    				$my_cal.fullCalendar('refetchEvents');
    			}
    		},$form.serialize());
    	},function($popup){
    		$popup.find('input[name=start_date]').val($.fullCalendar.formatDate( date, 'yyyy-MM-dd'));
		    $popup.find('input[name=end_date]').val($.fullCalendar.formatDate( date, 'yyyy-MM-dd'));
		    $popup.find('input[name=start_time]').val($.fullCalendar.formatDate( date, 'HH:mm'));
		    $popup.find('input[name=end_time]').val($.fullCalendar.formatDate( date, 'HH:mm'));
		    $popup.find('input[name=all_day]').removeAttr('selected');
		    if(allDay){
		    	$popup.find('select[name=all_day]').val('1');
		    }

    		//callback on load of modal window
    		$('#repeat_box')
				.dialog({
					modal: true,
					title: 'Repeat settings',
					height: 300,
					width: 450,
					autoOpen: false,
					appendTo: "#popup form",
					buttons: {
						Close: function(){
							$('#popup form').append($(this).html());
							$(this).dialog('close');
						}
					}
				});
    		
    		$popup.find('button[name=repeat]').bind('click',function(e){
    			e.preventDefault();
	    		$('#repeat_box').dialog('open');
				});
    	});
		},
		eventClick: function(calEvent, jsEvent, view) {
			if(calEvent.id.substr(0,1)=='b'){
	    	$.system.click_event('contacts/view/'+calEvent.id.substr(1,10),$('<span></span>'),null,'contacts');
	    }else if(calEvent.id.substr(0,1)=='t'){
	    	$.system.click_event('tasks/view/'+calEvent.id.substr(1,10),$('<span class="model"></span>'),null,'tasks');
	    }else if(calEvent.id.substr(0,1)=='a'){
	    	$.system.click_event('contacts/view/'+calEvent.id.substr(1,10),$('<span></span>'),null,'contacts');
	    }else{
	    	$.system.model_window('calendar/event/'+calEvent.id.substr(1,10),calEvent.title,650,550,function($form){
	    		//save function
	    		$.system.get_json($form.attr('action'),function(return_info){
	    			if(return_info==true){
	    				$form.parent().dialog("close");
	    				$my_cal.fullCalendar('refetchEvents');
	    			}
	    		},$form.serialize());
	    	},function($this_box){
	    		//callback on load of modal window
	    		$('#repeat_box')
					.dialog({
						modal: true,
						title: 'Repeat settings',
						height: 300,
						width: 450,
						autoOpen: false,
						buttons: {
							Close: function(){
								$('#popup form').append($(this).html());
								$(this).dialog('close');
							}
						}
					});
	    		
	    		$this_box.find('button[name=repeat]').bind('click',function(e){
	    			e.preventDefault();
		    		$('#repeat_box').dialog('open');
					});
	    	});
	    }
		},
		eventResize: function(event,dayDelta,minuteDelta,revertFunc) {
			if(confirm('Are you sure you want to change this item?')){
				if(event.end){
					var date_end = event.end.toUTCString();
				}else{
					var date_end = event.end;
				}
				
				$.system.get_json('calendar/update_time',function(return_info){
    			if(return_info!=true){
    				revertFunc();
            $.system.message('Event failed to update, please try again','error');
    			}
    		},"start="+event.start.toUTCString()+"&end="+date_end+"&id="+event.id+"&all_day="+event.allDay);
			}else{
				revertFunc();
			}
		},
		eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc){
			if(confirm('Are you sure you want to move this item?')){
				if(event.end){
					var date_end = event.end.toUTCString();
				}else{
					var date_end = event.end;
				}
				
				$.system.get_json('calendar/update_time',function(return_info){
    			if(return_info!=true){
    				revertFunc();
            $.system.message('Event failed to update, please try again','error');
    			}
    		},"start="+event.start.toUTCString()+"&end="+date_end+"&id="+event.id+"&all_day="+event.allDay);
			}else{
				revertFunc();
			}
    },
		
		theme: true,
		header: false,
		editable: true,
		firstDay: 1,
		eventSources: ['/calendar/all','http://www.google.com/calendar/feeds/en.uk%23holiday%40group.v.calendar.google.com/public/basic'],
		height: ($('#main').height()-42)
	});
	
	$.system.layout.options.center.onresize_end = function(){
		$('.calendar_grid').fullCalendar('option', 'height', ($('#main').height()-42));
		$('.calendar_grid').fullCalendar('render');
	};
	
	update_calendar_title();
	
	$('#cal_prev').click(function(){$('.calendar_grid').fullCalendar('prev');update_calendar_title();});
	$('#cal_next').click(function(){$('.calendar_grid').fullCalendar('next');update_calendar_title();});
	$('#cal_month').click(function(){$('.calendar_grid').fullCalendar('changeView','month');update_calendar_title();});
	$('#cal_week').click(function(){$('.calendar_grid').fullCalendar('changeView','agendaWeek');update_calendar_title();});
	$('#cal_day').click(function(){$('.calendar_grid').fullCalendar('changeView','agendaDay');update_calendar_title();});
	$('#cal_today').click(function(){$('.calendar_grid').fullCalendar('today');update_calendar_title();});
	
	var html_picker = '<select class="month"><option value="0">January</option><option value="1">February</option><option value="2">March</option><option value="3">April</option><option value="4">May</option><option value="5">June</option><option value="6">July</option><option value="7">August</option><option value="8">September</option><option value="9">October</option><option value="10">November</option><option value="11">December</option></select><select class="year" style="margin-left:10px;width:70px">';
	
	var cur_date = $('.calendar_grid').fullCalendar('getDate');
		
	var cur_start_date = cur_date.getFullYear()-5;
	var cur_end_date = cur_date.getFullYear()+5;
	
	for(cur_start_date;cur_start_date<cur_end_date;cur_start_date++){
		html_picker += '<option>'+cur_start_date+'</option>';
	}
	
	html_picker += '</select>';
	
	$('#title_bar h2').bind('click',function(){
		
		$("#popup").dialog("destroy")
		.html(html_picker)
		.find('select.year option:contains('+cur_date.getFullYear()+')').prop('selected', true).end()
		.find('select.month option[value='+cur_date.getMonth()+']').prop('selected', true).end()
		.dialog({
			modal: true,
			title: 'Change Month/Year',
			height: 125,
			width: 200,
			buttons: {
				Show: function(){
					$('.calendar_grid').fullCalendar('gotoDate',$(this).find('select.year').val(),$(this).find('select.month').val());
					update_calendar_title();
					$(this).dialog('close');
				}
			}
		});
	});
});

function update_calendar_title(){
  var view = $('.calendar_grid').fullCalendar('getView');
  $('#title_bar h2').html('Calendar - '+view.title);
}
$(function() {
	
	//system wide call structure
	$.system = {
		
		/*local vars*/
		layout : null,
		layout_selector : $('body'),
		layout_selector_header : '#header',
		layout_selector_main : '#main',
		layout_selector_menu: '#menu',
		layout_selector_search: '#search_results',
		current_url: '',
		current_data_grid: null,
		system_clock : $('#clock'),

		get_json : function(url,callback,post){
			$.ajax({
				url: url,
				dataType: 'json',
				type: 'post',
				data: 'is_ajax=1'+(post!=null ? '&'+post:''),
				success: function(return_data){
					$.system.ajax_complete(return_data,callback);
				}
			}).error(function(){ $.system.message('There was a system error, please try again and if this continues alert your system administrator','error')});
		},
		
		ajax_complete : function(return_data,callback){
			if(return_data.state){
				if(return_data.message!=''){
					$.system.message(return_data.message);
				}
				if(typeof callback==='function'){callback(return_data.data,return_data.extra);}
		  }else{
		  	if(return_data.message=='logged_out'){
		  		$.system.message('You have been logged out','error');
		  		window.location = '/';
		  	}else if(return_data.message!=''){
		  		$.system.message(return_data.message,'alert');
		  	}
		  }
		},
		
		submit_form : function($form,callback){
			$form.ajaxSubmit({
				type : 'post',
				dataType : 'json',
				data: {is_ajax:1},
				success : callback
			});
		},
		
		message : function(message,type){
			type = typeof type !== 'undefined' ? type : 'message';
			var sticky_var = (type=='error' ? true : false);
			var life_var = (type=='alert' ? 5000 : 3000);
			$.jGrowl(message, { life: life_var, theme: 'notification_'+type, sticky: sticky_var });
		},
		
		layout_setup : function(){
			this.layout = this.layout_selector.layout({
				north__paneSelector: this.layout_selector_header,
				center__paneSelector: this.layout_selector_main,
				west__paneSelector: this.layout_selector_menu,
				east__paneSelector: this.layout_selector_search,
				applyDefaultStyles: false,
				north__spacing_open: 0,
				north__size: 50,
				north__resizable: false,
				north__closable: false,
				west__resizable: false,
				west__closable: false,
				west__spacing_open: 0,
				west__size: 180,
				east__initClosed: true,
				east__size: 200,
				east__spacing_open: 0,
				east__spacing_closed: 0,
				east__closable: true,
				east__resizable: false,
				onresize: function(){$.system.resize_all();}
			});
		},
		
		resize_all : function(){
			if($('#content').hasClass('spacing')){
				$('#content').height($('#main').height()-($('#title_bar').outerHeight()+20)-$('#filter').outerHeight());
			}else{
				$('#content').height($('#main').height()-$('#title_bar').outerHeight()-$('#filter').outerHeight());
			}
			
			if($.system.current_data_grid!==null){
				$.system.current_data_grid.datagrid('fixed_thead_update');
			}
			
			if(typeof menu_scroller !== "undefined"){
				menu_scroller.tinyscrollbar_update();
			}
			if(typeof search_scroller !== "undefined"){
				search_scroller.tinyscrollbar_update();
			}
		},
		
		click_event : function(url,$item,event,callback,menu_selection){
			this.current_url = url;
			if(event!==null){
				event.preventDefault();
			}
  		
  		if($item.hasClass('model')){
  			if($item.attr('data-title')){
  				var window_title = $item.attr('data-title');
  			}else{
  				var window_title = $item.text();
  			}
  			
  			var width = ($item.attr('data-width') ? $item.attr('data-width') : 650);
  			var height = ($item.attr('data-height') ? $item.attr('data-height') : 500);
  				
  			$.system.model_window(url,window_title,width,height,function($form){
					
					$.system.submit_form($form,function(return_info){
						$.system.ajax_complete(return_info,function(){
		    			$form.parent().dialog("close");
		    			if($item.attr('data-menu-click')){
		    				$('#menu a[data-selection='+$item.attr('data-menu-click')+']').click();
		    			}
						});
		    	});
				});

  		}else{
  			this.get_json(url,function(return_html){
  				if($('div.data_grid').size()>0){
  					$('div.data_grid').datagrid('destroy');
  					$.system.current_data_grid = null;
  				}
		  		$('#main').html(return_html);
		  		if($('div.data_grid:not(.style_only)').size()>0){
		  			$.system.current_data_grid = $('div.data_grid:not(.style_only)').datagrid();
		  		}
		  		if(typeof callback==='function'){callback();}
		  		if(menu_selection!==null){
		  			$('#menu a').removeClass('active').filter($('#menu a[data-selection='+menu_selection+']').addClass('active'));
		  		}
		  		if(history){
		  			if($item.get(0).tagName=='TR'){
		  				var link_name = $item.find('td:first').text();
		  			}else{
		  				var link_name = $item.text();
		  			}
						//history.pushState({h_url:url,menu_selection:menu_selection},link_name, url);
					}else{
						//window.location.hash='!'+url;
					}
		  		$.system.resize_all();
  			});
  		}
		},
		
		go_back_js : function(state){
			if(typeof state !== 'undefined' && typeof state.h_url !== 'null'){
				this.get_json(state.h_url,function(return_html){
					if($('div.data_grid').size()>0){
						$('div.data_grid').datagrid('destroy');
						$.system.current_data_grid = null;
					}
		  		$('#main').html(return_html);
		  		if($('div.data_grid:not(.style_only)').size()>0){
		  			$.system.current_data_grid = $('div.data_grid:not(.style_only)').datagrid();
		  		}
		  		if(typeof callback==='function'){callback();}
		  		if(state.menu_selection!==null){
		  			$('#menu a').removeClass('active').filter($('#menu a[data-selection='+state.menu_selection+']').addClass('active'));
		  		}
		  		$.system.resize_all();
			  });
			}
		},
		
		model_window : function(url,title,width,height,save_function,callback){
			this.get_json(url,function(return_html){
				
				if($('#popup').is(':data(dialog)')){
					$("#popup").dialog("destroy");
				}
				
				$("#popup").html(return_html).dialog({
					modal: true,
					title: title,
					height: height,
					width: width,
					buttons: {
						Save: function(){
							save_function($(this).find('form'));
						},
						Cancel: function(){
							$(this).dialog('close');
						}
					}
				});
				
				if(typeof callback==='function'){callback($("#popup"));}
				
			});
		}
	}

	$.system.layout_setup();
	$.system.resize_all();
	
	$(document).on('click','a:not(table.ui-datepicker-calendar a, .ui-datepicker-header a), *[data-click]',function(event){
		var $self = $(this);
		
		event.stopPropagation();
		
		if($self.get(0).tagName=='A'){
			var url = $self.attr('href');
		}else{
			var url = $self.attr('data-click');
		}
		
		if($self.hasClass('new_window')){
			event.preventDefault();
			window.open(url,'_blank');
		}else if($self.hasClass('event')){
			$.system.get_json(url);
		}else{
			if(!$self.hasClass('click-through')){
				event.preventDefault();
				$.system.click_event(url,$self,event,null,$self.attr('data-selection'));
			}
		}
  });
  
  $(document).on('click','.tabs_box ul li',function(){
  	$(this).parent().find('li').removeClass('active').filter($(this).addClass('active'));
  	$tabs = $(this).parent().parent();
  	$tabs.find('.tab').hide().filter($tabs.find('.'+$(this).attr('data-tab')).show());
  });
  
  $(document).on('mouseover','.date_picker, .time_picker',function(){
  	if($(this).hasClass('date_picker')){
  		$(this).datepicker('destroy').datepicker({
				changeMonth: true,
				changeYear: true,
				yearRange: "c-1:c+5",
				dateFormat: "yy-mm-dd"
			});
  	}
  	
  	if($(this).hasClass('time_picker')){
  		$(this).timepicker({
				hourGrid: 4,
				minuteGrid: 15,
				stepMinute: 5,
				showButtonPanel: false
			});
  	}
  	
  });
  
  $(document).on('submit','form:not(#header_search)',function(event){
  	event.preventDefault();
  	$.system.submit_form($(this),function(return_info){
			$.system.ajax_complete(return_info,function(return_html){
				$('#main').html(return_html);
				$.system.resize_all();
			});
		});			
  });
  
  $('#header_search').bind('submit',function(event){
  	event.preventDefault();
  	$.system.get_json('/search',function(return_html){
			$('#search_results .overview').html(return_html);
			$.system.layout.open('east');
			$('#search_close').show();
		},'search='+$('#header_search input').val());
  });
  
  $('#search_close').bind('click',function(){
  	$('#search_results .overview').html('');
  	$.system.layout.close('east');
  	$(this).hide();
  	$('#header_search input').val('');
  });
  
  $('#load_status').hide();
	
	$(document).ajaxStart(function(){
		$('#load_status').show();
	}).ajaxStop(function(){
		$('#load_status').hide();
	}).ajaxError(function(){
		$('#load_status').hide();
	});
	
	var menu_scroller = $('#menu').tinyscrollbar({wheel: 20});
	var search_scroller = $('#search_results').tinyscrollbar({wheel: 20});
	
	//record current initial state
	//history.replaceState({h_url: document.location.href,menu_selection:'overview'},'Dashboard',document.location.href);
	
	//on pop state load the last page
	//window.onpopstate = function(event) {
	//	$.system.go_back_js(event.state);
	//};
	//getthetime();
	//setInterval(function(){getthetime();},1000);
});

function getthetime(){
	var mydate=new Date()
	var hours=mydate.getHours();
	var minutes=mydate.getMinutes();
	var dn="am";
	if(hours>=12){dn="pm"}
	if(hours>12){hours=hours-12}
	if(hours==0){hours=12}
	if(minutes<=9){minutes="0"+minutes}
	$.system.system_clock.text(hours+":"+minutes+dn);
}
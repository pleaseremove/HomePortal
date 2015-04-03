(function($) {
	
	var self = null;
	var hit_offset = false;

	var methods = {
		init : function(){
			self = this;
			this.find('#apply_filter').on('click',methods.filter_bind);
			methods.fixed_thead();
			methods.scroll_offset();
			methods.extra_slidedown();
			return self;
		},
		
		destroy : function(){
			this.find('#apply_filter').off('click');
			this.find('#header-fixed th[data-sort]').off('click');
		},
		
		filter_bind : function(){
			$.system.get_json(self.attr('data-filter'),function(return_html,extra_data){
				self.attr('data-limit',0);
				self.find('#content table.data_grid tbody').html(return_html);
				if(extra_data){
					$('#extra_fold').html(extra_data);
				}
				$.system.resize_all();
				methods.fixed_thead_update();
			},$('#filter .filter_item select,#filter .filter_item input').serialize());
		},
		
		order_bind : function(){
			if(!$(this).hasClass('up') && !$(this).hasClass('down')){
				$(this).addClass('down');
			}else if($(this).hasClass('down')){
				$(this).removeClass('down').addClass('up');
			}else{
				$(this).removeClass('up');
			}
			
			$.system.get_json(self.attr('data-filter'),function(return_html,extra_data){
				self.find('#content table.data_grid tbody').html(return_html);
				if(extra_data){
					$('#extra_fold').html(extra_data);
				}
				$.system.resize_all();
				methods.fixed_thead_update();
			},$('#filter .filter_item select,#filter .filter_item input').serialize()+methods.order_by_string());
		},
		
		order_by_string : function(){
			var item_string = '';
			
			self.find('#header-fixed th[data-sort]').each(function(){
				if($(this).hasClass('up')){
					item_string+=$(this).attr('data-sort')+' DESC,';
				}else if($(this).hasClass('down')){
					item_string+=$(this).attr('data-sort')+' ASC,';
				}
			});
			
			if(item_string!=''){
				item_string = '&orderby='+item_string;
			}
			
			return item_string;
		},
		
		fixed_thead_update : function(){
			self.find('#header-fixed').css('width',self.find('#content table.data_grid:not(#header-fixed)').width());
			
			self.find('#content table.data_grid:not(#header-fixed) thead tr th').each(function(index){
				newwidth = (index!=0 ? ($(this).width()-1) : $(this).width());
				self.find('#header-fixed thead th:eq('+index+')').width(newwidth);
			});
		},
		
		fixed_thead : function(callback){
			var cloned = '';
			var $fake_header = $('<table style="position:absolute;" class="data_grid" id="header-fixed"><thead class="box_shadow"><tr></tr></thead></table>');
			self.find('#content table.data_grid thead tr th').each(function(){
				cloned = cloned+'<th'+($(this).attr('data-sort')!=null ? ' class="sort" data-sort="'+$(this).attr('data-sort')+'"' : '')+' style="width:'+$(this).width()+'px">'+$(this).text()+'</th>';
			});
			$fake_header.find('tr').html(cloned);
			$fake_header.css('top',(self.find('#content table.data_grid').position().top===null ? 0 : self.find('#content table.data_grid').position().top));
			$fake_header.css('width',self.find('#content table').width());// used to be -17
			$fake_header.find('th[data-sort]').on('click',methods.order_bind);
			self.find('#content').append($fake_header);
		},
		
		scroll_offset : function(){
			
			$('#content').scroll(function(){
				if((self.find('#content table.data_grid').height()-200-$('#content').height())<=$('#content').scrollTop() && hit_offset===false){
					hit_offset = true;
					methods.load_extra_content();
				}
			});
		},
		
		load_extra_content : function(){
			if(hit_offset===true){
				$.system.get_json(self.attr('data-filter'),function(return_html,extra_data){
					if(return_html.match(/Found<\/td>\s*<\/tr>/) === null){
						self.find('#content table.data_grid tbody').append(return_html);
						if(extra_data){
							$('#extra_fold').html(extra_data);
						}
						methods.fixed_thead_update();
						$.system.resize_all();
						self.attr('data-limit',parseInt(self.attr('data-limit'))+100);
					}
					hit_offset = false;
				},$('#filter .filter_item select,#filter .filter_item input').serialize()+methods.order_by_string()+'&scroll_limit='+self.attr('data-limit'));
			}
		},
		
		extra_slidedown : function(){
			$('#extra_button').on('click',function(){
				if($(this).hasClass('up')){
					$(this).removeClass('up');
				}else{
					$(this).addClass('up');
				}
				
				$('#extra_fold').slideToggle(200);
			});
		}
	};

	$.fn.datagrid = function(method) {
	
		if(methods[method]){
			return methods[method].apply(this,Array.prototype.slice.call(arguments,1));
		}else if(typeof method==='object' || !method) {
			return methods.init.apply(this,arguments );
		}else{
			$.error('Method '+method+' does not exist on jQuery.data_grid');
		}
	};
})(jQuery);
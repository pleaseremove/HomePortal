<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="{base_url()}" />
		<!--  Page details -->
		<title>{$ci->site->display->title}</title>
		<link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
		<link rel="icon" type="image/x-icon" href="favicon.ico" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<!-- Styles -->
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/main.css" />
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/fonts.css" />
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/forms.css" />
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/menu.css" />
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/menu_icons_mono.css" />
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/header.css" />
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/content.css" />
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/colours.css" />
		
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/libs/Aristo/Aristo.css" />
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/libs/jquery.jgrowl.css" />
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/libs/fullcalendar.css" />
		
		<link rel="stylesheet" title="default" type="text/css" media="screen" href="_style/libs/jqplot1.0.8r1250/jquery.jqplot.min.css" />
		
		<!-- Javascript Libs-->
		<script src="_js/libs/jquery-1.10.1.min.js" type="text/javascript"></script>
		
		<script src="_js/libs/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

		<script src="_js/libs/jquery.layout-1.3.0.rc30.79.js" type="text/javascript"></script>
		
		<script src="_js/libs/jquery.jgrowl.min.js" type="text/javascript"></script>
		
		<script src="_js/libs/jquery-ui-timepicker-addon.min.js" type="text/javascript"></script>
		
		<script src="_js/libs/fullcalendar.min.js" type="text/javascript"></script>
		
		<script src="_js/libs/gcal.js" type="text/javascript"></script>
		
		<script src="_js/libs/jquery.tinyscrollbar.min.js" type="text/javascript"></script>
		
		<script src="_js/libs/jquery.form.min.js" type="text/javascript"></script>
		
		<script src="https://maps.googleapis.com/maps/api/js?v=3.10&sensor=false"></script>
		
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/jquery.jqplot.min.js"></script>
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.categoryAxisRenderer.min.js"></script>
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.highlighter.min.js"></script>
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.canvasTextRenderer.min.js"></script>
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.barRenderer.min.js"></script>
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.pieRenderer.min.js"></script>
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.dateAxisRenderer.min.js"></script>
		
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.ohlcRenderer.min.js"></script>
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.highlighter.min.js"></script>
		<script type="text/javascript" src="_js/libs/jqplot1.0.8r1250/plugins/jqplot.cursor.min.js"></script>
		
		<script src="_js/main.js" type="text/javascript"></script>
		<script src="_js/datagrid.js" type="text/javascript"></script>
	
	</head>
	<body>
		<div id="header" class="header_color">
			<h1 id="logo" class="logo">HomePortal</h1>
			<div id="date_time">{$smarty.now|date_format:'%A, %e'}<sup>{if $smarty.now|date_format:'%e'==1}st{elseif $smarty.now|date_format:'%e'==2}nd{elseif $smarty.now|date_format:'%e'==3}rd{else}th{/if}</sup> {$smarty.now|date_format:'%B %Y'}<span id="clock"></span></div>
			<img style="right:475px;position:absolute;top:14px;" alt="Loading..." src="_images/layout/ajax-loader.gif" id="load_status" />
			<ul>
				<li><a href="import-export/">Import &amp; Export</a></li>
				<li class="nolink">Settings
					<ul class="header_color">
						<li><a href="settings/users/view/{$ci->mylogin->user()->id()}" class="model">My Account</a></li>
						{if $ci->mylogin->user()->is_admin==1}
						<li><a href="settings/users/all">Users</a></li>
						<li><a href="settings/family/view" class="model" data-height="150">Family Settings</a></li>
						<li><a href="settings/data_types/all">Contact Data</a></li>
						<li><a href="settings/parent_categories">Parent Categories</a></li>
						{/if}
					</ul>
				</li>
				<li><a href="login/logout" class="click-through">Logout</a></li>
			</ul>
			<form id="header_search" onsubmit="return false;">
				<span id="search_close" title="Close search results"></span>
				<input type="text" placeholder="Search..."/>
			</form>
		</div><!--#header-->
		
		<div id="menu" class="box_background border_color_right right_shadow">
			<div class="scrollbar">
				<div class="track"><div class="thumb"><div class="end"></div></div></div></div>
				<div class="viewport">
					<div class="overview">
						{include file="side_menu.tpl"}
					</div>
				</div>
			</div>
    </div><!--#menu-->

	  <div id="main">
	  	{if isset($full_load)}
	  		{$full_load}
	  	{else}
	  		{include file="overview.tpl"}
	  	{/if}
	  </div><!--#main-->
	  
	  <div id="search_results" class="box_background border_color_left">
	  	<div class="scrollbar">
				<div class="track"><div class="thumb"><div class="end"></div></div></div></div>
				<div class="viewport">
					<div class="overview">
						Search results
					</div>
				</div>
			</div>
	  </div>
	  
	  <div id="popup">
	  	
	  </div>

  </body>
</html>

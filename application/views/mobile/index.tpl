<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>HomePortal</title>
		<link rel="stylesheet" href="/_style/mobile/my.css" />
		<link rel="stylesheet" href="/_js/mobile/jquery.mobile-1.4.1.min.css" />
		<link rel="stylesheet" href="/_js/mobile/jquery.mobile.theme-1.4.1.min.css" />
		<script src="/_js/libs/jquery-1.10.1.min.js"></script>
		<script src="/_js/mobile/jquery.mobile-1.4.1.min.js"></script>
		{*<script src="/_js/mobile/my.js"></script>*}
	</head>
	<body>
    <!-- Home -->
    <div data-role="page" id="contacts-page">
      <div data-theme="b" data-role="header" data-position="fixed">
      	<a href="/mobile/" class="ui-btn-left">Home</a>
        <h1>{$page_title}</h1>
        <a href="/mobile/logout" class="ui-btn-right">Logout</a>
        <div data-role="navbar" data-iconpos="top">
        	<ul>
          	<li><a href="/mobile/contacts/" data-transition="none"{if $section=='contacts'} class="ui-btn-active ui-state-persist"{/if}>Contacts</a></li>
            <li><a href="/mobile/money/" data-transition="none"{if $section=='money'} class="ui-btn-active ui-state-persist"{/if}>Money</a></li>
            <li><a href="/mobile/events/" data-transition="none"{if $section=='events'} class="ui-btn-active ui-state-persist"{/if}>Events</a></li>
            <li><a href="/mobile/tasks/" data-transition="none"{if $section=='tasks'} class="ui-btn-active ui-state-persist"{/if}>Tasks</a></li>
            <li><a href="/mobile/notes/" data-transition="none"{if $section=='notes'} class="ui-btn-active ui-state-persist"{/if}>Notes</a></li>
          </ul>
        </div>
        {if $section=='money'}
	        <div data-role="navbar" data-iconpos="top">
	        	<ul>
	        		<li><a href="/mobile/money/edit/0/" data-transition="none" data-theme="a">New Money</a></li>
	        		<li><a href="/mobile/money/transfer/" data-transition="none" data-theme="a">New Transfer</a></li>
	            <li><a href="/mobile/money/all/" data-transition="none" data-theme="a">List</a></li>
	          </ul>
	        </div>
	       {/if}
      </div>
      
      <div data-role="content" style="padding: 15px">
      	{$inner_template}
      </div>
      
    </div>
    
    <script>
        //App custom javascript
    </script>
</body>
</html>
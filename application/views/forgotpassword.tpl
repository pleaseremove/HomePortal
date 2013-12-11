<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$ci->site->display->title}</title>
<link rel="stylesheet" type="text/css" href="_styles/login.css" />
<link rel="stylesheet" type="text/css" href="_styles/awesome.css" />
<!--[if eq IE 7]>
<link rel="stylesheet" type="text/css" href="_styles/ie7.css" />
<![endif]-->
</head>

<body>
<img src="images/layout/background.png" class="bg" alt="background image"/>
<div id="content-wrapper">
	<h1 class="dps">DPS Global</h1>
	<h1 class="pageheading">{$pageheading|truncate:60:"..."}</h1>

	<div class="login-content">
		<form action="login/requestpassword" method="post">
			<div class="notification {if $error}warning{else}information{/if}"><div>{$error|default:'Enter registered email address'}</div></div>
			<p>
				<label for="email">Email Address</label>
				<input type="text" name="email" id="email" value="" />
			</p>
			<p>
				<input type="submit" class="awesome" name="login" value="Request New Password" />
				<a href="login" class="smallerAction">Back to login</a>
			</p>
		</form>
	</div>
	
		<div id="copyright">
		{$ci->site->display->copyright}
	</div>
</div>
</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="{base_url()}" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="_style/login.css" />
<script type="text/javascript" src="_js/libs/jquery-1.7.2.min.js"></script>
<title>{$ci->site->display->title}</title>
<script>

$(function() {
	$('#username').focus();
});

</script>
</head>

<body id="login">
	<div class="wrapper">
		<div class="header">
			<h1>{$pageheading|truncate:60:"..."}</h1>
		</div>
		<div class="login-content">
			<form action="login/checklogin" method="post" autocomplete="off">
				<div class="notification {if $error}error{else}information{/if}"><div>{$error|default:'Please Login'}</div></div>
				<p>
					<label for="username">Username</label>
					<input type="text" name="username" id="username" value="" />
				</p>
				<p>
					<label for="password">Password</label>
					<input type="password" name="password" value="" />
				</p>
				<p>
					<label for="public_place">Public Place</label>
					<input type="checkbox" name="public_place" value="1" />
				</p>
				<p>
					<input type="submit" class="button" name="login" value="Sign In" />
					<a href="login/forgotpassword" class="smallerAction">Forgot Your Password</a>
				</p>
			</form>
		</div>
	</div>
</body>
</html>
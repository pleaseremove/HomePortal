<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>HomePortal: Login</title>
		<link rel="stylesheet" href="/_js/mobile/jquery.mobile-1.4.1.min.css" />
		<script src="/_js/libs/jquery-1.10.1.min.js"></script>
		<script src="/_js/mobile/jquery.mobile-1.4.1.min.js"></script>
		<link rel="stylesheet" href="/_style/mobile/my.css" />
		<script src="/_js/mobile/my.js">
		</script>
	</head>
	<body>
    <div data-role="page" id="login-page">
    	<div data-theme="b" data-role="header" data-position="fixed">
        <h1>HomePortal</h1>
      </div>
    
      <div data-role="content" style="padding: 15px">
      	<form method="post" action="/mobile/login/checklogin">
      		<div data-role="fieldcontain">
						<label for="name">Username:</label>
						<input type="text" name="username" id="username" value="" />
					</div>
					<div data-role="fieldcontain">
						<label for="name">Password:</label>
						<input type="password" name="password" id="password" value="" />
					</div>
					<input type="submit" value="Login" />
      	</form>
      </div>
      
    </div>
</body>
</html>
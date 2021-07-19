# Nginx NodeJS
```
nginx-node-js/
	|-Dockerfile			<-- required: Dockerfile
	|-app/					<-- required: nodejs source code
	|-nginx/
		|-sites-enabled/	<-- required: nginx config file
		|-www/ 				<-- optional: static files
		|-certs/			<-- optional: ssl certs
```
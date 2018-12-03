## Proxy To AppSys

Here are some example proxy configurations.

### Apache

Use the following settings to proxy Apache traffic to AppSys. Replace 'PATH' with the path your using for AppSys

```
SSLProxyEngine On
SSLProxyVerify none 
SSLProxyCheckPeerCN off
SSLProxyCheckPeerName off
SSLProxyCheckPeerExpire off

SetEnv proxy-chain-auth

ProxyPreserveHost On
ProxyPassMatch /PATH/(.*) https://127.0.0.1:8443/$1
ProxyPassReverse /PATH https://127.0.0.1:8443/
```

### Nginx

User the following settings to proxy Nginx traffic to AppSys. Replace 'PATH' with the path your using for AppSys

```
location ~ ^/PATH/(.*)$ {
  proxy_set_header Host $host;
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    
  proxy_ssl_server_name on;
  proxy_ssl_verify      off;
    
  proxy_set_header Host $host;
  proxy_pass            https://127.0.0.1:8443/$1;
}
```

CONF-NGINX 

--------------------------------------------------------------------------------------------------------------------------------------------------------

echo 'server {

    if ($host = pruebas-script.duckdns.org) {

        return 301 https://$host$request_uri;

    } # managed by Certbot
 
 
    if ($host = failchat.duckdns.org) {

        return 301 https://$host$request_uri;

    } # manejado por Certbot
 
    listen 80;

    server_name pruebas-script.duckdns.org;

    return 301 https://$host$request_uri;
 
 
}
 
server {

listen 443 ssl;

server_name pruebas-script.duckdns.org;

    ssl_certificate /etc/ssl/certs/pruebas-script.crt;

# manejado por Certbot

    ssl_certificate_key /etc/ssl/private/pruebas-script.duckdns.org.key; # manejado por Certbot
 
location /_mtrix {

proxy_pass http://10.13.2.247:8008;
 
proxy_set_header X-Forwarded-For $remote_addr;

client_max_body_size 10M;

}
 
 
}
 
server {

listen 8443 ssl;

server_name pruebas-script.duckdns.org;
 
ssl_certificate /etc/ssl/certs/pruebas-script.crt; # manejado por Certbot

ssl_certificate_key /etc/ssl/private/pruebas-script.duckdns.org.key; # mane>
 
location /_mtrix {

proxy_pass http://10.13.2.247:8008;
 
proxy_set_header X-Forwarded-For $remote_addr;

client_max_body_size 10M;

}

}' | sudo tee /etc/nginx/sites-available/failchat.duckdns.org

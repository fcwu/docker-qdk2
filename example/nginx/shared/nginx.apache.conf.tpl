ProxyRequests off
ProxyPass /nginx http://127.0.0.1:<@http_port@>
ProxyPassReverse /nginx http://127.0.0.1:<@http_port@>

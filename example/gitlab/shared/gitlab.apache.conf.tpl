ProxyRequests off
ProxyPass /gitlab http://127.0.0.1:<@http_port@>/gitlab
ProxyPassReverse /gitlab http://127.0.0.1:<@http_port@>/gitlab

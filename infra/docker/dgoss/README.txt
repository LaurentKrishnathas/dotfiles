curl -L https://raw.githubusercontent.com/aelsabbahy/goss/master/extras/dgoss/dgoss -o /usr/local/bin/dgoss
chmod +rx /usr/local/bin/dgoss


dgoss edit -p 8080:80 nginx:1.11.10

goss a file /var/log/nginx/access.log /var/log/nginx/error.log
goss a process nginx
goss a port 80
goss a package nginx
goss a http http://localhost
exit

dgoss run nginx




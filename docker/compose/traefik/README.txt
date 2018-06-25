the following command line and toml file works with letsencrypt
WARNING: Make sure port 80 and port 443 is accessible to letsencrypt server => make it public
  traefik:
    image: traefik:v1.3.8
    command: |-
      --acme.acmelogging="true"
      --acme.domains='test.website.click'
      --acme.entrypoint="https"
      --acme.email="<lkdevjobs@googlemail.com>"
      --acme.storage="/etc/traefik/acme/acme.json"
      --acme.ondemand="true"
      --acme.onhostrule="true"
      --logLevel=DEBUG
      --debug
      --web
      --defaultEntryPoints="http,https"
      --docker
      --docker.watch
      --docker.domain="docker.local"
      --docker.exposedbydefault="false"
      --entryPoints='Name:http Address::80 Redirect.EntryPoint:https'
      --entryPoints='Name:https Address::443'

  #      --entryPoints='Name:https Address::443 TLS'
  #      --acme.caserver=https://acme-staging.api.letsencrypt.org/directory
    
-----

# https://medium.com/@lukastosic/traefik-docker-reverse-proxy-and-much-much-more-a39b24b9d959

#WARNING: make sure port 80 and 443 is accessible to all, so letsencrypt can contact that port

logLevel = "DEBUG"

defaultEntryPoints = ["http", "https"]

[web]
address = ":8080"



[entryPoints]

[entryPoints.http]
address = ":80"
[entryPoints.http.redirect]
entryPoint = "https"

[entryPoints.https]
address = ":443"
[entryPoints.https.tls]

[acme]
email = "lkdevjobs@googlemail.com"
storage = "/etc/traefik/acme/acme.json"
entryPoint = "https"
acmeLogging = true
onDemand = false
OnHostRule = false
#caServer = "https://acme-staging.api.letsencrypt.org/directory"

[[acme.domains]]
main = "test.test.click"

[docker]
endpoint = "unix:///var/run/docker.sock"
domain = "docker.local"
watch = true
exposedbydefault = false  
  
  
  
  
  
  
  
  
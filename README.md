# certdump-rpi
docker container with curl and jq, to extract traefik certificates from consul keystore in k8s cronjob

mount persistent storage on /certs, execute with e.g. (assumes no auth needed on consul)

curl -X GET http://consul.local:8500/v1/kv/traefik/acme/account/object | jq -c '.[0]["Value"]' | base64 -d | gzip -dc | jq -r '.DomainsCertificate.Certs[] | select(.Domains.Main=="'*.MYDOMAIN.COM'") | .Certificate' > acme.json 

cat acme.json | jq -r '.Certificate' | base64 -d > fullchain.pem 
cat acme.json | jq -r '.PrivateKey' | base64 -d > privkey.pem

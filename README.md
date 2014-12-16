# ssl-proxy-docker

## Usage
Create & tag image:
```
docker build -t nuada/ssl-proxy .
```

Create container:
```
docker run -d -p 443:443 -p 80:80 --link dokuwiki:dokuwiki nuada/ssl-proxy
```

# code-server
A [code-server](https://github.com/coder/code-server) with build tools and vim.
## How-to
```
mkdir -p ~/.config
git clone git:github.com/hk6an6/code-server.git
cd code-server
sh make-code-server.sh MyProject
docker-compose up -d .
cat ~/.config/code-server/config.yaml\
| grep password \
| awk '{print $2}'
```
## About the files in this repo
### Dockerfile
Produces a docker image for code-server.

### make-code-server.sh
Produces a docker compose file to run a new project.

### compose.yaml
This is an example. It demonstrates the output of make-code-server.sh.

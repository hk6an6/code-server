# code-server
A [code-server](https://github.com/coder/code-server) with build tools and vim. Needs Docker.
## How-to
### Installing Docker with docker-compose
```
sudo apt update && \
sudo apt install apt-transport-https ca-certificates curl software-properties-common && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
sudo apt update && \
apt-cache policy docker-ce && \
sudo apt install docker-ce && \
sudo usermod -aG docker ${USER} && \
su - ${USER} && \
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose && \
chmod +x ~/.docker/cli-plugins/docker-compose
```
### Using code-server
```
mkdir -p ~/.config
git clone git:github.com/hk6an6/code-server.git
cd code-server
sh make-code-server.sh MyProject
docker-compose up -d .
cat ~/.config/code-server/config.yaml\
| grep password \
| awk '{print $2}'
# then browse to http://localhost:8080
```
### Refreshing the image
```
docker build -t aragonn/code-server:latest -f ./Dockerfile . && \
docker push aragonn/code-server:latest
```
## About the files in this repo
### Dockerfile
Produces a docker image for code-server.

### make-code-server.sh
Produces a docker compose file to run a new project.

### compose.yaml
This is an example. It demonstrates the output of make-code-server.sh.

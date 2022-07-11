#!/bin/bash
PROJECT_NAME="$1"
# Run this script in a folder where you will host the files for the project.
# After running this script, use Docker compose to start code-server:
# docker-compose up -d

# creates a compose file for a new project
makeComposeFile() {
  cat <<EOF | tee compose.yaml
version: '3.9'
services:
  code-server:
    image: aragonn/code-server:latest
    container_name: code-server
    network_mode: host
    user: $(id -u):$(id -g)
    environment:
      - TZ=America/Los_Angeles
      - DOCKER_USER=$USER
    volumes:
      - "$HOME/.config:/home/coder/.config"
      - "$PWD:/home/coder/$PROJECT_NAME"
EOF
}

if [ "$PROJECT_NAME" = "" ]; then
  echo "Missing inputs. Use:\n\tsh $0 <project_name>";
else
  makeComposeFile
fi


# The image name for the Docker container
IMAGE_NAME = mage_demo

# The name of the Docker Compose file
COMPOSE_FILE = docker-compose.yaml

# Build the Docker image
build:
	docker buildx create --use --name temp-builder
	docker buildx build --platform linux/amd64,linux/arm64 -t donb4iu/$(IMAGE_NAME) --push .
	docker buildx rm temp-builder

# Run the containers in the background
up:
	docker-compose -f $(COMPOSE_FILE) up -d

# Stop the containers
down:
	docker-compose -f $(COMPOSE_FILE) down

# Rebuild the Docker image and restart the containers
rebuild: build down up

# Show logs
logs:
	docker-compose -f $(COMPOSE_FILE) logs

# Connect to the mage container
exec:
	docker exec -it mage /bin/bash

# Open the browser
browse:
	open http://localhost:6789

#create new project
create:
	docker run -it -p 6789:6789 -v /Users/donbuddenbaum/Documents/mage_demo:/home/src mageai/mageai \
  /app/run_app.sh mage start $(IMAGE_NAME)

#get latest image
latest:
	docker pull mageai/mageai:latest

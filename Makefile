IMAGE ?= docker-web-server
NAME  ?= web

.PHONY: build run stop logs health shell stats clean up down

build:   ## Build the image
	docker build -t $(IMAGE) .

run:     ## Run a container (plain docker, no compose)
	docker run -d --name $(NAME) -p 8080:8080 --restart unless-stopped $(IMAGE)

stop:    ## Stop and remove the container
	-docker stop $(NAME)
	-docker rm $(NAME)

logs:    ## Follow logs
	docker logs -f $(NAME)

health:  ## Show health status
	docker inspect --format '{{.State.Health.Status}}' $(NAME)

shell:   ## Open a shell inside the container
	docker exec -it $(NAME) sh

stats:   ## Live CPU and memory use
	docker stats $(NAME)

up:      ## Start with Docker Compose
	docker compose up -d --build

down:    ## Stop Compose stack
	docker compose down

clean: stop ## Remove container and image
	-docker rmi $(IMAGE)

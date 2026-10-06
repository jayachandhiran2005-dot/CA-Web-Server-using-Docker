# Docker command cheat sheet

## Images
```bash
docker build -t docker-web-server .     # build an image from the Dockerfile
docker images                           # list local images
docker history docker-web-server        # see the layers
docker rmi docker-web-server            # remove an image
```

## Container lifecycle
```
create -> start -> (running) -> stop -> (exited) -> rm
                      |-> pause / unpause
                      |-> restart
```
```bash
docker run -d --name web -p 8080:8080 docker-web-server   # create + start
docker ps                  # running containers
docker ps -a               # all containers, including stopped
docker stop web            # graceful stop (SIGTERM, then SIGKILL after 10s)
docker start web           # start a stopped container
docker restart web
docker pause web && docker unpause web
docker rm web              # delete a stopped container (add -f to force)
```

## Inspect and debug
```bash
docker logs -f --tail 100 web              # follow the last 100 log lines
docker exec -it web sh                     # shell inside the container
docker inspect web                         # full JSON details
docker inspect --format '{{.State.Health.Status}}' web
docker stats                               # live CPU / memory / network
docker top web                             # processes inside the container
docker diff web                            # files changed vs. the image
docker events                              # live stream of Docker events
```

## Housekeeping
```bash
docker system df          # disk used by images, containers, volumes
docker system prune       # remove stopped containers, dangling images, unused networks
```

## Compose
```bash
docker compose up -d --build
docker compose ps
docker compose logs -f
docker compose down
```

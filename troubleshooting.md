# Troubleshooting

| Symptom | How to investigate | Common fix |
|---|---|---|
| Container exits immediately | `docker ps -a`, then `docker logs web` | Fix the config error shown in the logs (e.g. `nginx -t` failure) |
| `port is already allocated` | `docker ps`, or check what uses the port on the host | Stop the other process or map a different host port: `-p 8081:8080` |
| Page not loading | `docker ps` (is it running?), `curl -i localhost:8080/healthz` | Check the port mapping and firewall |
| Status shows `unhealthy` | `docker inspect --format '{{json .State.Health}}' web` | Read the failing check output, then fix the app or the health endpoint |
| Container keeps restarting | `docker logs web`, `docker inspect web` (look at ExitCode and RestartCount) | Fix the crash; a restart policy only hides it |
| 403 / 404 for your files | `docker exec web ls -l /usr/share/nginx/html` | Make sure files were copied into the image and are readable |
| Changes to the site don't show | Image was not rebuilt | `docker compose up -d --build` |
| Permission denied writing files | Read-only root filesystem is on | Write only to `/tmp` or a mounted volume |
| Disk filling up | `docker system df` | `docker system prune`; set log rotation (already set in compose) |

## Useful checks
```bash
docker exec web nginx -t                              # validate the nginx config
docker exec web wget -qO- http://127.0.0.1:8080/nginx_status   # connection metrics
docker run --rm -it docker-web-server sh              # poke around a throwaway container
```

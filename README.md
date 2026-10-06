# Web Server using Docker

An nginx web server packaged in a Docker container, with health checks, hardening, and notes on the container lifecycle, monitoring, and troubleshooting.

## Goals
- Learn Docker containerization basics
- Deploy and manage a web server inside Docker containers
- Understand container lifecycle and commands
- Monitor container health and troubleshoot issues
- Explore container-based app deployment best practices

## Project layout
| Path | Purpose |
|---|---|
| `Dockerfile` | Image definition (unprivileged nginx, healthcheck) |
| `nginx/default.conf` | Server config: `/healthz`, `/nginx_status`, security headers, gzip |
| `site/` | The static website being served |
| `docker-compose.yml` | Hardened, production-style run configuration |
| `Makefile` | Shortcuts for common commands |
| `docs/commands.md` | Command cheat sheet and lifecycle diagram |
| `docs/troubleshooting.md` | Symptom to fix table |
| `docs/best-practices.md` | Deployment best practices |

## Quick start
Requires Docker (and the Compose plugin).

```bash
# Option A: Docker Compose
docker compose up -d --build

# Option B: plain Docker
docker build -t docker-web-server .
docker run -d --name web -p 8080:8080 docker-web-server
```
Open http://localhost:8080 or run `curl -i localhost:8080/healthz`.

## Watch the lifecycle
```bash
docker ps                                   # running
docker stop web && docker ps -a             # exited
docker start web                            # running again
docker inspect --format '{{.State.Health.Status}}' web   # starting -> healthy
docker logs -f web                          # access and error logs
docker stats web                            # CPU / memory
docker rm -f web                            # removed
```

## Experiments
1. Edit `site/index.html`, rebuild, and see the change.
2. Break `nginx/default.conf` on purpose, run it, and diagnose with `docker logs`.
3. Make `/healthz` return 500, then watch the status flip to `unhealthy`.
4. `docker kill web` and check how the restart policy reacts.
5. Add `--memory 32m` and watch `docker stats`.
6. Try writing a file inside the running container and see why the read-only filesystem blocks it.

## License
MIT

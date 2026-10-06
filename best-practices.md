# Container deployment best practices

- **Small, specific base images**: Alpine-based, with a pinned tag (e.g. `stable-alpine`) instead of `latest`
- **Run as non-root**: this project uses the unprivileged nginx image
- **One process per container**: scale by running more containers
- **Immutable containers**: read-only root filesystem, writable `tmpfs` only where needed
- **Drop capabilities** and set `no-new-privileges`
- **Health checks** so Docker and orchestrators can detect a broken container
- **Resource limits** (CPU and memory) so one container can't starve the host
- **Log to stdout/stderr** and rotate logs
- **No secrets in images or git**: use environment variables, Docker secrets, or a secret manager
- **Use `.dockerignore`** to keep build context small and avoid leaking files
- **Order Dockerfile layers** from least to most frequently changed to use the build cache
- **Scan images** for vulnerabilities (e.g. `docker scout cves`, Trivy)
- **Tag images with versions or commit SHAs** for reproducible, reversible deployments
- **Restart policy** (`unless-stopped`) for resilience, not as a substitute for fixing crashes

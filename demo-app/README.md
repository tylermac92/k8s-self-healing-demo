# Self-Healing Demo App

A simple FastAPI app for Kubernetes self-healing demonstrations.

## Endpoints

- `GET /healthz` – Returns 200 (healthy) or 500 (unhealthy)  
- `GET /readyz` – Returns 200 if "ready" has been set, else 500  
- `POST /fail` – Toggles health state  
- `POST /ready` – Marks app as ready

## Docker

```bash
docker build -t self-healing-app .
docker run -p 8000:8000 self-healing-app
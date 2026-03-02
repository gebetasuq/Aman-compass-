# [Service Name] – Aman Compass Microservice

This microservice is part of the Aman Compass backend. It handles [brief description of what this service does].

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/health` | Health check |
| GET | `/` | Service information |
| [Add more as needed] | ... | ... |

## Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `PORT` | Port the service runs on | `3001` |
| `SERVICE_NAME` | Name of the service | `auth-service` |
| `DATABASE_URL` | PostgreSQL connection string (if applicable) | `postgresql://user:pass@localhost:5432/db` |
| [Add service‑specific variables] | ... | ... |

Copy `.env.example` to `.env` and fill in your values.

## Running Locally

```bash
npm install
cp .env.example .env
npm run dev

from celery import Celery
import os

redis_url = os.getenv("REDIS_URL", "redis://localhost:6379/0")
app = Celery("tasks", broker=redis_url, backend=redis_url)

@app.task
def process_query(query_text: str):
    # Simulate heavy processing
    return f"Processed: {query_text}"

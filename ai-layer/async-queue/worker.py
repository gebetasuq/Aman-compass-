from celery_app import app
import time

if __name__ == "__main__":
    app.worker_main()

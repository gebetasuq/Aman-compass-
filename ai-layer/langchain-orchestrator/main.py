from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(title="LangChain Orchestrator")

class Query(BaseModel):
    text: str
    emirate: str = "Dubai"

@app.get("/health")
async def health():
    return {"status": "OK"}

@app.post("/ask")
async def ask(query: Query):
    # Placeholder – integrate LangChain here
    return {"answer": f"You asked: {query.text} (emirate: {query.emirate})"}

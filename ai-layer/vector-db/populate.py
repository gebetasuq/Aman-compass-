import pinecone
import os
from dotenv import load_dotenv

load_dotenv()

pinecone.init(api_key=os.getenv("PINECONE_API_KEY"), environment=os.getenv("PINECONE_ENV"))
index_name = "aman-compass"

# Create index if not exists
if index_name not in pinecone.list_indexes():
    pinecone.create_index(index_name, dimension=1536, metric="cosine")

index = pinecone.Index(index_name)

# Placeholder: add your embedding logic
vectors = [
    {"id": "1", "values": [0.1]*1536, "metadata": {"text": "sample"}}
]
index.upsert(vectors)

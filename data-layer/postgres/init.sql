Example schema for service registry
CREATE TABLE IF NOT EXISTS entities (
    id SERIAL PRIMARY KEY,
    emirate VARCHAR(50),
    name VARCHAR(255),
    description TEXT,
    category VARCHAR(100),
    contact_info JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add other tables as needed

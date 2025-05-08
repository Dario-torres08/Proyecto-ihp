-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some 
-- en Schema.sql
CREATE TABLE tasks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    title TEXT NOT NULL,
    is_done BOOL DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);


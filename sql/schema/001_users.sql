-- +goose Up
CREATE TABLE users (
    id UUID PRIMARY KEY,
    name text NOT NULL UNIQUE,
    updated_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL
);

-- +goose Down
DROP TABLE users;

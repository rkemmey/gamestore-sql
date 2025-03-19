-- Drop the table if it exists
DROP TABLE IF EXISTS game;

-- Create Game Table
CREATE TABLE game (
    game_id SERIAL PRIMARY KEY,
    game_title VARCHAR(255), 
    quantity INT,
    price DECIMAL(5, 2)
);

ALTER TABLE game 
ALTER COLUMN game_title 
SET NOT NULL;

-- Insert Sample Data into Game Table
\COPY game FROM './data/game.csv' WITH CSV HEADER;


DROP TABLE IF EXISTS action_figure;

CREATE TABLE action_figure (
    id SERIAL PRIMARY KEY,
    action_figure_title VARCHAR(255) UNIQUE CHECK (
        action_figure_title ~ '^[A-Z][A-Za-z0-9-]*$'
    ),
    quantity INT CHECK (quantity BETWEEN 1 AND 30),
    price DECIMAL(10,2) CHECK (price BETWEEN 10.00 AND 100.00)
);

\COPY action_figure FROM './data/action_figure.csv' WITH CSV HEADER;

DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    employee_name VARCHAR(255) CHECK (
        employee_name ~ '^[A-Z][a-z]+( [A-Z][a-z]+)*$'
    ),
    position VARCHAR(50) CHECK (
        position IN ('Sales Associate', 'Store Manager', 'Inventory Clerk', 
                     'Customer Service Representative', 'IT Specialist', 
                     'Marketing Coordinator', 'Assistant Manager', 
                     'Finance Analyst', 'Security Officer', 'HR Coordinator')
    ),
    salary DECIMAL(10,2) CHECK (salary BETWEEN 16.67 AND 31.25)
);

\COPY employee FROM './data/employee.csv' WITH CSV HEADER;

DROP TABLE IF EXISTS poster;

CREATE TABLE poster (
    id SERIAL PRIMARY KEY,
    poster_title VARCHAR(255) UNIQUE CHECK (
        poster_title ~ '^[A-Z][A-Za-z0-9-]*$'
    ),
    quantity INT CHECK (quantity BETWEEN 1 AND 30),
    price DECIMAL(10,2) CHECK (price BETWEEN 6.00 AND 20.00)
);

\COPY poster FROM './data/poster.csv' WITH CSV HEADER;
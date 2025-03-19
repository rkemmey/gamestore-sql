DROP TABLE IF EXISTS genre CASCADE;

CREATE TABLE genre (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(20) UNIQUE NOT NULL CHECK(genre_name ~ '^[A-Za-z]')
);

\COPY genre FROM './data/genre.csv' WITH CSV HEADER;


DROP TABLE IF EXISTS gaming_engine CASCADE;

CREATE TABLE gaming_engine (
    engine_id SERIAL PRIMARY KEY,
    engine_name VARCHAR(20) UNIQUE NOT NULL
);

\COPY gaming_engine FROM './data/gaming_engine.csv' WITH CSV HEADER;


DROP TABLE IF EXISTS game CASCADE;

CREATE TABLE game (
    game_id SERIAL PRIMARY KEY,
    game_title VARCHAR(255) UNIQUE NOT NULL,
    quantity INT NOT NULL CHECK(quantity > 0 AND quantity < 51),
    price DECIMAL(5, 2) NOT NULL CHECK(price > 10 AND price < 60),
    engine_id INT,
    FOREIGN KEY (engine_id) REFERENCES gaming_engine(engine_id)
);

--\COPY game FROM './data/game.csv' DELIMITER ',' CSV HEADER;


DROP TABLE IF EXISTS genre_game CASCADE;

CREATE TABLE genre_game (
    game_id INT,
    genre_id INT,
    PRIMARY KEY (game_id, genre_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

--\COPY genre_game FROM './data/genre_game.csv' WITH CSV HEADER;


DROP TABLE IF EXISTS action_figure;

CREATE TABLE action_figure (
    id INT PRIMARY KEY,
    action_figure_title VARCHAR UNIQUE NOT NULL CHECK (action_figure_title ~ '^[A-Za-z0-9 _-]+$'),
    quantity INT NOT NULL CHECK(quantity > 0 AND quantity < 31),
    price DECIMAL(5,2) NOT NULL CHECK(price > 10 AND price < 100.01)
);

\COPY action_figure FROM './data/action_figure.csv' WITH CSV HEADER;


DROP TABLE IF EXISTS employee CASCADE;

CREATE TABLE employee (
    id INT PRIMARY KEY,
    employee_name VARCHAR NOT NULL CHECK (employee_name ~ '^[A-Za-z ]+$'),
    position VARCHAR NOT NULL CHECK (position IN (
        'Sales Associate',
        'Store Manager',
        'Inventory Clerk',
        'Customer Service Representative',
        'IT Specialist',
        'Marketing Coordinator',
        'Assistant Manager',
        'Finance Analyst',
        'Security Officer',
        'HR Coordinator'
    )),
    salary DECIMAL(7,2) NOT NULL CHECK (salary > 31987.19 AND salary < 60000.01)
);

\COPY employee FROM './data/employee.csv' WITH CSV HEADER;


DROP TABLE IF EXISTS poster;

CREATE TABLE poster (
    id SERIAL PRIMARY KEY,
    poster_title VARCHAR UNIQUE NOT NULL CHECK (poster_title ~ '^[A-Za-z0-9 _-]+$'),
    quantity INT NOT NULL CHECK (quantity > 0 AND quantity < 31),
    price DECIMAL(4,2) NOT NULL CHECK (price <= 20.00 AND price > 6)
);


\COPY poster FROM './data/poster.csv' WITH CSV HEADER;


DROP TABLE IF EXISTS social_security;

CREATE TABLE social_security(
    id SERIAL PRIMARY KEY,
    employee_id INT,
    ssn VARCHAR(11) UNIQUE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

\COPY social_security FROM './data/social_security.csv' WITH CSV HEADER;

DROP TABLE IF EXISTS shifts;

CREATE TABLE shifts (
    id SERIAL PRIMARY KEY,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

\COPY shifts FROM './data/shifts.csv' WITH CSV HEADER;

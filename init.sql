CREATE EXTENSION IF NOT EXISTS postgis;

-- Таблиця для сегментів дороги
CREATE TABLE road_segment (
    segment_id SERIAL PRIMARY KEY,
    road_name VARCHAR(255),
    start_coordinates GEOGRAPHY(Point, 4326),
    end_coordinates GEOGRAPHY(Point, 4326)
);

-- Таблиця для трафіку
CREATE TABLE traffic (
    traffic_id SERIAL PRIMARY KEY,
    segment_id INT REFERENCES road_segment(segment_id),
    traffic_intensity INT,
    average_speed FLOAT,
    last_updated TIMESTAMP
);

-- Таблиця для подій
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    segment_id INT REFERENCES road_segment(segment_id),
    event_type VARCHAR(50),
    event_location GEOGRAPHY(Point, 4326),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    status VARCHAR(20)
);

-- Таблиця для маршрутів
CREATE TABLE routes (
    route_id SERIAL PRIMARY KEY,
    start_location VARCHAR(255),
    end_location VARCHAR(255),
    waypoints JSON,
    travel_time FLOAT
);

-- Таблиця для користувачів
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL
);

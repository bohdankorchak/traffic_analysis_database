CREATE EXTENSION IF NOT EXISTS postgis;

-- Таблиця для маршрутів
CREATE TABLE routes (
    id SERIAL PRIMARY KEY, -- Унікальний ідентифікатор маршруту
    timestamp TIMESTAMP DEFAULT NOW(), -- Час запису
    start_address TEXT NOT NULL, -- Початкова адреса
    start_lat FLOAT NOT NULL, -- Початкова широта
    start_lng FLOAT NOT NULL, -- Початкова довгота
    end_address TEXT NOT NULL, -- Кінцева адреса
    end_lat FLOAT, -- Кінцева широта
    end_lng FLOAT, -- Кінцева довгота
    distance_text VARCHAR(50) NOT NULL, -- Відстань текстом
    distance_value INTEGER NOT NULL, -- Відстань у метрах
    duration_text VARCHAR(50) NOT NULL, -- Тривалість текстом
    duration_value INTEGER NOT NULL, -- Тривалість у секундах
    duration_in_traffic_text VARCHAR(50), -- Тривалість у трафіку текстом
    duration_in_traffic_value INTEGER -- Тривалість у трафіку в секундах
);

-- Таблиця для сегментів дороги
CREATE TABLE route_segments (
    id SERIAL PRIMARY KEY, -- Унікальний ідентифікатор сегмента
    timestamp TIMESTAMP DEFAULT NOW(), -- Час запису
    start_lat FLOAT NOT NULL, -- Початкова широта сегмента
    start_lng FLOAT NOT NULL, -- Початкова довгота сегмента
    end_lat FLOAT NOT NULL, -- Кінцева широта сегмента
    end_lng FLOAT NOT NULL, -- Кінцева довгота сегмента
    duration_in_traffic INTEGER, -- Тривалість у пробках
    normal_duration INTEGER, -- Нормальна тривалість
    polyline TEXT NOT NULL -- Полілайн сегмента
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

-- Таблиця для користувачів
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL
);

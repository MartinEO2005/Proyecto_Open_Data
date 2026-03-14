CREATE DATABASE IF NOT EXISTS flights_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE flights_db;

-- Limpieza ordenada por FKs
DROP TABLE IF EXISTS flight;
DROP TABLE IF EXISTS flight_performance;
DROP TABLE IF EXISTS airport;
DROP TABLE IF EXISTS airline;
DROP TABLE IF EXISTS aircraft;
DROP TABLE IF EXISTS aircraft_model;

-- Modelos de avión
CREATE TABLE aircraft_model (
  model_id INT AUTO_INCREMENT PRIMARY KEY,
  model_code VARCHAR(64) NOT NULL UNIQUE,
  description VARCHAR(255)
);

-- Aeronaves
CREATE TABLE aircraft (
  aircraft_id INT AUTO_INCREMENT PRIMARY KEY,
  tail_number VARCHAR(16) NOT NULL UNIQUE,
  model_id INT,
  year_mfr SMALLINT,
  aircraft_age SMALLINT,
  FOREIGN KEY (model_id) REFERENCES aircraft_model(model_id)
);

-- Aerolíneas
CREATE TABLE airline (
  airline_id INT AUTO_INCREMENT PRIMARY KEY,
  iata_code VARCHAR(8) UNIQUE,
  name VARCHAR(128),
  dot_id INT
);

-- Aeropuertos
CREATE TABLE airport (
  airport_id INT AUTO_INCREMENT PRIMARY KEY,
  iata VARCHAR(8) UNIQUE,
  name VARCHAR(128),
  city VARCHAR(64),
  state VARCHAR(64),
  country VARCHAR(64),
  lat DECIMAL(9,6),
  lon DECIMAL(9,6),
  airport_seq_id INT,
  city_market_id INT,
  state_fips VARCHAR(8),
  wac VARCHAR(8)
);

-- Rendimiento del vuelo (opcional 1:1)
CREATE TABLE flight_performance (
  perf_id INT AUTO_INCREMENT PRIMARY KEY,
  departure_delay_groups VARCHAR(32),
  dep_time_blk VARCHAR(32),
  arrival_delay_groups VARCHAR(32),
  arr_time_blk VARCHAR(32),
  wheels_off DATETIME,
  wheels_on DATETIME
);

-- Vuelos (hecho principal)
CREATE TABLE flight (
  flight_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  flight_date DATE NOT NULL,
  sched_dep_dt DATETIME,
  sched_arr_dt DATETIME,
  dep_dt DATETIME,
  arr_dt DATETIME,

  airline_id INT,
  aircraft_id INT,
  origin_id INT,
  dest_id INT,
  perf_id INT,

  cancelled TINYINT(1) DEFAULT 0,
  diverted TINYINT(1) DEFAULT 0,
  dep_delay_minutes INT,
  dep_delay VARCHAR(32),
  arr_delay_minutes INT,
  arr_delay VARCHAR(32),
  airtime INT,
  crs_elapsed_time INT,
  actual_elapsed_time INT,
  distance INT,

  marketing_airline_network VARCHAR(128),
  operated_or_branded_code_share_partners VARCHAR(255),
  dot_id_marketing_airline INT,
  iata_code_marketing_airline VARCHAR(8),
  flight_number_marketing_airline VARCHAR(32),
  operating_airline VARCHAR(128),
  dot_id_operating_airline INT,
  iata_code_operating_airline VARCHAR(8),
  flight_number_operating_airline VARCHAR(32),

  dep_del15 TINYINT(1),
  arr_del15 TINYINT(1),
  distance_group INT,
  div_airport_landings INT,

  model_source ENUM('faa','inferred','missing') DEFAULT 'missing',

  INDEX idx_date (flight_date),
  INDEX idx_airline (airline_id),
  INDEX idx_aircraft (aircraft_id),
  INDEX idx_origin (origin_id),
  INDEX idx_dest (dest_id),

  FOREIGN KEY (airline_id) REFERENCES airline(airline_id),
  FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id),
  FOREIGN KEY (origin_id) REFERENCES airport(airport_id),
  FOREIGN KEY (dest_id) REFERENCES airport(airport_id),
  FOREIGN KEY (perf_id) REFERENCES flight_performance(perf_id)
);

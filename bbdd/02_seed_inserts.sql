USE flights_db;

-- Modelo de avión
INSERT INTO aircraft_model (model_code, description)
VALUES ('B737-800','Boeing 737-800');

-- Aeronave
INSERT INTO aircraft (tail_number, model_id, year_mfr, aircraft_age)
VALUES ('N465AW', 1, 2010, 14);

-- Aerolínea
INSERT INTO airline (iata_code, name, dot_id)
VALUES ('WN','Southwest',12345);

-- Aeropuertos
INSERT INTO airport (iata, name, city, state, country, lat, lon, airport_seq_id, city_market_id, state_fips, wac)
VALUES ('JFK','John F Kennedy Intl','New York','NY','USA',40.641311,-73.778139,1,1001,'36','22');

INSERT INTO airport (iata, name, city, state, country, lat, lon, airport_seq_id, city_market_id, state_fips, wac)
VALUES ('LAX','Los Angeles Intl','Los Angeles','CA','USA',33.941589,-118.40853,2,2002,'06','91');

-- Rendimiento del vuelo
INSERT INTO flight_performance (departure_delay_groups, dep_time_blk, arrival_delay_groups, arr_time_blk, wheels_off, wheels_on)
VALUES ('0','0800-0859','0','1000-1059','2024-01-01 08:05:00','2024-01-01 09:55:00');

-- Vuelo normalizado
INSERT INTO flight (
    flight_date, sched_dep_dt, sched_arr_dt, dep_dt, arr_dt,
    airline_id, aircraft_id, origin_id, dest_id, perf_id,
    cancelled, diverted, dep_delay_minutes, arr_delay_minutes,
    airtime, crs_elapsed_time, actual_elapsed_time, distance,
    marketing_airline_network, operated_or_branded_code_share_partners,
    dot_id_marketing_airline, iata_code_marketing_airline, flight_number_marketing_airline,
    operating_airline, dot_id_operating_airline, iata_code_operating_airline,
    flight_number_operating_airline, dep_del15, arr_del15,
    distance_group, div_airport_landings, model_source
)
VALUES (
    '2024-01-01','2024-01-01 08:00:00','2024-01-01 10:00:00',
    '2024-01-01 08:05:00','2024-01-01 09:55:00',
    1, 1, 1, 2, 1,
    0, 0, 5, -3,
    110, 120, 115, 3983,
    'WN Network','WN Partners',
    12345,'WN','5678',
    'Southwest',12345,'WN',
    '1234',0,0,
    5,0,'faa'
);

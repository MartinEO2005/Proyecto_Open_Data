
### Hecho principal

* **Flight** (evento de vuelo)
  * `flight_id`, `FlightDate`, `sched_dep_dt`, `sched_arr_dt`, `dep_dt`, `arr_dt`
  * Medidas: `Cancelled`, `Diverted`, `DepDelayMinutes`, `ArrDelayMinutes`, `AirTime`, `CRSElapsedTime`, `ActualElapsedTime`, `Distance`, `DepDel15`, `ArrDel15`, `TaxiOut`, `TaxiIn`, `ArrDelay`, `DepDelay`, `DistanceGroup`, `DivAirportLandings`
  * FK → `airline_id`
  * FK → `aircraft_id`
  * FK → `origin_id`
  * FK → `dest_id`

### Dimensiones

* **Airline**
  * `airline_id`, `name`, `iata_code`, `dot_id`
  * Marketing/operating codes (`DOT_ID_Marketing_Airline`, `IATA_Code_Marketing_Airline`, etc.) se guardan aquí.
* **Airport**
  * `airport_id`, `iata`, `name`, `city`, `state`, `country`, `lat`, `lon`
  * Incluye atributos como `AirportSeqID`, `CityMarketID`, `StateFips`, `Wac`.
* **Aircraft**
  * `aircraft_id`, `tail_number`, `year_mfr`, `aircraft_age`
  * FK → `model_id`
* **AircraftModel**
  * `model_id`, `model_code`, `description`
* **FlightPerformance**
  * Atributos relacionados con bloques de tiempo y grupos de retraso:
    `DepartureDelayGroups`, `DepTimeBlk`, `ArrivalDelayGroups`, `ArrTimeBlk`, `WheelsOff`, `WheelsOn`.

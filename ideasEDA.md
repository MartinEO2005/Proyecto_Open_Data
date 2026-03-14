## Aircraft model y compañía aérea

#### Caso de estudio: comparativa mercado por modelo × aerolínea

* **Objetivo:** ver qué modelos dominan cada aerolínea y cómo varía la puntualidad por combinación.
* **Gráficas:**
  * **Heatmap:**
    * **Filas:** Operating_Airline (o Airline si ya normalizaste).
    * **Columnas:** MODEL.
    * **Celda:** retraso medio ArrDelayMinutes o % ArrDel15.
  * **Small multiples (faceted boxplots):**
    * **Paneles:** top-6 aerolíneas por volumen.
    * **Eje x:** MODEL | **Eje y:** ArrDelayMinutes.
  * **Stacked bar chart (composición de flota):**
    * **Eje x:** aerolínea.
    * **Segmentos:** % de vuelos por MODEL.
    * **Color:** % on-time vs delayed (>15).
* **KPIs:**
  * **Retraso medio:** por (Operating_Airline, MODEL).
  * **% >15 min:** por (Operating_Airline, MODEL).
  * **Volumen:** conteo de vuelos por (Operating_Airline, MODEL).
* **Interpretación esperada:** detectar dependencia de modelos con peor performance y modelos con retrasos recurrentes independientemente de la aerolínea.

## Edad de la aeronave y su efecto

#### Caso de estudio: 737-800 vs A320 vs A321 por edad

* **Objetivo:** comprobar si la edad correlaciona con retrasos/cancelaciones o si es proxy de ruta/operador.
* **Gráficas:**
  * **Scatter con smoothing (LOESS/regresión):**
    * **x:** aircraft_age | **y:** ArrDelayMinutes | **color:** MODEL | **tamaño:** vuelos por tail.
  * **Violin plots binned:**
    * **Bins:** 0–5, 6–10, 11–15, 16+.
    * **Distribución:** ArrDelayMinutes.
  * **Boxplots estratificados por modelo:**
    * **Paneles:** MODEL.
    * **Eje x:** bin de aircraft_age | **Eje y:** ArrDelayMinutes.
  * **Bar chart:**
    * **Eje x:** bin de aircraft_age | **Barras:** % Cancelled y % Diverted.
* **KPIs:**
  * **Correlación:** Pearson/Spearman de aircraft_age vs ArrDelayMinutes.
  * **Odds ratio:** cancelación por bin de edad.
* **Control de confusores:** ajustar por Distance, congestión (vuelos/hora por aeropuerto), temporada, Operating_Airline; reportar coeficientes y CI.
* **Interpretación esperada:** si el efecto de la edad se diluye tras ajuste, es proxy de operativa/ruta; si persiste, indica potencial efecto de mantenimiento/fiabilidad.

## Retrasos por ruta y geografía

#### Caso de estudio: top rutas por volumen vs por retraso

* **Objetivo:** encontrar pares Origen–Destino problemáticos y entender drivers (distancia, aeropuerto, operador).
* **Gráficas:**
  * **OD matrix heatmap:**
    * **Filas:** Origin | **Columnas:** Dest | **Celda:** ArrDelayMinutes promedio (filtrar top-50 aeropuertos).
  * **Mapa de rutas (arc lines):**
    * **Geometría:** segmentos entre origin_lat/lon y dest_lat/lon.
    * **Grosor:** volumen de vuelos | **Color:** retraso medio o % ArrDel15.
  * **Scatter Distance vs Delay con densidad:**
    * **x:** Distance | **y:** ArrDelayMinutes | **color:** OriginState o Operating_Airline.
  * **Small multiples por ruta:**
    * **Paneles:** rutas específicas | **Serie:** retraso medio mensual.
* **KPIs:**
  * **Retraso medio y % >15:** por ruta.
  * **Variabilidad:** desviación estándar del retraso por ruta.
* **Interpretación esperada:** rutas cortas con alta variabilidad → congestión/turnaround; rutas largas con retrasos crecientes → operativa o slots.

## Operaciones en aeropuerto y franjas horarias

#### Caso de estudio: 3 hubs vs 3 regionales

* **Objetivo:** medir impacto de congestión y franja horaria sobre retrasos.
* **Gráficas:**
  * **Heatmap hora × día de semana:**
    * **x:** DepTimeBlk | **y:** weekday(FlightDate) | **Celda:** DepDelayMinutes promedio.
  * **Bubble chart por aeropuerto:**
    * **x:** avg scheduled flights per hour (derivado de sched_dep_dt).
    * **y:** avg dep delay.
    * **Tamaño:** volumen | **Color:** % on-time.
  * **Lag plot intra-aeropuerto:**
    * **x:** retraso en vuelo t-1 | **y:** retraso en vuelo t (ordenados por dep_dt) para ver propagación.
* **KPIs:**
  * **Retraso medio por franja (DepTimeBlk).**
  * **Taxi medio:** TaxiOut + TaxiIn por aeropuerto.
  * **Correlación:** ocupación horaria vs retraso.
* **Interpretación esperada:** detectar ventanas críticas donde pequeñas perturbaciones se amplifican.

## Code-share: marketing vs operating airline

#### Caso de estudio: vuelos en marca compartida vs no code-share

* **Objetivo:** comparar puntualidad cuando el vuelo es comercializado por una aerolínea y operado por otra.
* **Gráficas:**
  * **Paired boxplots:**
    * **Grupos:** Operating_Airline (dos cajas: code-share sí/no).
    * **Métrica:** ArrDelayMinutes.
  * **Grouped bar chart:**
    * **x:** Marketing_Airline_Network.
    * **Barras:** retraso medio cuando opera la propia vs un tercero.
  * **Sankey diagram:**
    * **Flujo:** Marketing → Operating | **Color:** retraso medio (o % ArrDel15).
* **KPIs:**
  * **Diferencia de retraso medio:** operating vs marketing.
  * **% cancelaciones:** code-share vs no code-share.
* **Interpretación esperada:** evaluar penalizaciones de puntualidad y efecto reputacional de operar con terceros.

## Mapas de todas las rutas coloreadas por estado del vuelo

#### Caso de estudio: panorama nacional de estado operativo

* **Objetivo:** visualizar todas las rutas y distinguir cancelados/divertidos/demorados.
* **Gráficas:**
  * **Mapa de rutas categórico:**
    * **Geometría:** líneas Origin–Dest para EEUU continental.
    * **Color:**
      * Verde: on-time (ArrDel15 = 0 y Cancelled = 0 y Diverted = 0).
      * Amarillo: delayed (ArrDel15 = 1).
      * Rojo: cancelled (Cancelled = 1).
      * Morado: diverted (Diverted = 1).
    * **Grosor:** volumen de vuelos.
  * **Mapa de nodos (airport bubbles):**
    * **Tamaño:** volumen total.
    * **Color:** proporción de cada estado (stacked donut por aeropuerto si tu lib lo soporta).
* **KPIs:**
  * **Distribución de estados:** % on-time, delayed, cancelled, diverted por ruta y por aeropuerto.
  * **Rutas con alta tasa de cancelación/desvío:** ranking nacional.

## TaxiOut, TaxiIn y eventos WheelsOff/WheelsOn

#### Caso de estudio: eficiencia de superficie y secuenciación

* **Objetivo:** relacionar tiempos de taxi y eventos de ruedas con retrasos de salida/llegada.
* **Gráficas:**
  * **Boxplots por aeropuerto:**
    * **Variable:** TaxiOut y TaxiIn.
    * **Strata:** DepTimeBlk o ArrTimeBlk.
  * **Scatter CRSElapsedTime vs ActualElapsedTime:**
    * **Color:** Operating_Airline | **Tamaño:** Distance.
    * **Diagonal de referencia:** igualdad; distancia vertical = gap de eficiencia.
  * **Timeline WheelsOff/WheelsOn (densidad temporal):**
    * **Kernel density** por hora del día para ver picos operativos.
  * **Stacked bars por aerolínea:**
    * **Segmentos:** promedio TaxiOut, AirTime, TaxiIn → descomposición del ActualElapsedTime.
* **KPIs:**
  * **Taxi promedio y variabilidad:** por aeropuerto y franja.
  * **Gap de programación:** ActualElapsedTime − CRSElapsedTime por aerolínea/modelo.
  * **Distribución horaria de WheelsOff/On:** picos y dispersión.

## Diseño del dashboard integrado

* **Sección market/model:**
  * **Heatmap** airline × model (ArrDelayMinutes).
  * **Stacked bar** composición de flota y puntualidad.
* **Sección rutas:**
  * **Mapa nacional** de rutas con color por estado y grosor por volumen.
  * **OD heatmap** para top aeropuertos.
* **Sección operativa:**
  * **Bubble chart** congestión vs retraso por aeropuerto.
  * **Boxplots** TaxiOut/TaxiIn por franja.
  * **Scatter** CRSElapsed vs ActualElapsed.
* **Sección code-share:**
  * **Paired boxplots** y **Sankey** Marketing → Operating.

## **PUEDO HACER VISTAS PARA CADA RAMA (ACORDARSE MARTIN)**

* * **agg_airline_model:** mean ArrDelayMinutes, pct ArrDel15, count por (Operating_Airline, MODEL).
* **Vistas rutas:**
  * **agg_route:** mean ArrDelayMinutes, pct ArrDel15, pct Cancelled, pct Diverted, count por (Origin, Dest).
* **Vistas aeropuerto/franjas:**
  * **agg_airport_timeblk:** mean DepDelayMinutes, mean TaxiOut, mean TaxiIn por (Airport, DepTimeBlk).
* **Vistas code-share:**
  * **agg_codeshare:** métricas por (Marketing_Airline_Network, Operating_Airline) con flag code_share.
* **Vistas eficiencia:**
  * **agg_elapsed_gap:** mean(ActualElapsedTime − CRSElapsedTime) por (Operating_Airline, MODEL).

# Analisis y Prediccion de Retrasos de Vuelos

## Resumen

Proyecto para analizar, clasificar y predecir retrasos de vuelos nacionales en EE. UU. Se combinan datos de vuelos con coordenadas de aeropuertos para trazar rutas y con datos de aeronaves (por tail number) para estudiar el efecto del modelo y la edad del aparato. El campo de investigacion es amplio: permite analisis por ruta, por aerolinea operadora vs comercializadora, por modelo de avion, por franjas horarias y por condiciones geograficas.

[Flight Status Prediction](https://www.kaggle.com/datasets/robikscube/flight-delay-dataset-20182022/data?select=Combined_Flights_2022.csv): https://www.kaggle.com/datasets/robikscube/flight-delay-dataset-20182022/data?select=Combined_Flights_2022.csv

## Objetivos 

- Calcular retraso medio por ruta y por aerolinea operadora.
- Comparar puntualidad entre aerolinea operadora y aerolinea comercializadora (code-share).
- Evaluar si ciertos modelos o edades de aeronaves presentan mayor probabilidad de retraso o cancelacion.
- Visualizar rutas en mapas y colorearlas por retraso medio.
- Construir modelos de clasificacion/regresion para predecir probabilidad y magnitud de retraso.

## Enriquecimientos clave

- **Coordenadas**: origin_lat, origin_lon, dest_lat, dest_lon (merge con tabla de aeropuertos) para mapeo y analisis espacial.
- **Aeronave**: Tail_Number -> model, year_manufactured, seats, engine_type, aircraft_age (merge con base de aeronaves).
- **Marketing/code-share**: IATA_Code_Marketing_Airline, Operated_or_Branded_Code_Share_Partners para analizar diferencias operadora vs comercializadora.

## Analisis especificos posibles

- Analisis de puntualidad por aerolinea real vs aerolinea comercializadora.
- Estudios de code-share: medir si vuelos vendidos bajo marca compartida tienen mas retrasos o cancelaciones.
- Comparativa por modelo y edad de aeronave (p. ej. 737-800 vs A320neo).
- Modelos predictivos (XGBoost, RandomForest, redes) para probabilidad de retraso > 15 min y magnitud del retraso.
- Analisis espacial: hotspots de retrasos por region, correlacion con clima y congestión.

## Fuentes y notas

- OpenSky ofrece una base de datos de aeronaves (crowdsourced) util para obtener modelo/registro por tail number.
- PyOpenSky facilita acceso programatico a datos de OpenSky y sus datasets.
- Para cobertura comercial y campos adicionales (seats, capacidad), existen proveedores pagos como Aviation Edge.

## Conclusión

Con las uniones propuestas (aeropuertos y aeronaves) el proyecto pasa de un analisis de retrasos basico a una investigacion multidimensional que permite responder preguntas operativas y de negocio sobre puntualidad, mantenimiento y diseno de rutas.

---

**IDEAS**

La idea que habíamos acordado era **unir este dataset con otro de aeropuertos** (o con una tabla de coordenadas IATA) para obtener **latitud/longitud** de origen y destino y así **trazar rutas en un mapa** y analizar retrasos por ruta y por aerolínea. También comentaste que harías la unión más tarde; el flujo típico es:

* limpiar este dataset (hecho arriba),
* cargar `airports.csv` con columnas `IATA`, `lat`, `lon`,
* hacer `merge` por `ORIGIN` y `DEST` para añadir coordenadas,
* agregar por ruta/carrier y visualizar.

### Variables de aerolíneas y vuelos

* `DOT_ID_Operating_Airline`
  * Es un identificador numérico asignado por el *Department of Transportation (DOT)* a la aerolínea que **opera realmente** el vuelo.
  * Útil si trabajas con bases oficiales del DOT que usan estos IDs en vez de códigos IATA.
* `IATA_Code_Operating_Airline`
  * El código IATA (2 letras) de la aerolínea que **opera** el vuelo.
  * Es el más práctico para merges con tablas de aerolíneas, análisis por compañía, o visualizaciones.
* `DOT_ID_Marketing_Airline`
  * Identificador DOT de la aerolínea que **comercializa** el vuelo (puede ser distinta de la que lo opera).
  * Sirve para distinguir vuelos en *code-share* (ejemplo: vendido por Delta pero operado por SkyWest).
* `IATA_Code_Marketing_Airline`
  * Código IATA de la aerolínea que **vende** el vuelo.
  * Útil si quieres analizar la puntualidad desde la perspectiva de la aerolínea comercializadora.
* `Flight_Number_Marketing_Airline`
  * Número de vuelo tal como lo comercializa la aerolínea de marketing.
  * Sirve para identificar el vuelo en itinerarios de pasajeros o en sistemas de reservas.
* `Marketing_Airline_Network`
  * Indica la red de marketing de la aerolínea (ejemplo: Delta Connection, United Express).
  * Útil para analizar desempeño por red de marca, no solo por aerolínea individual.
* `Operated_or_Branded_Code_Share_Partners`
  * Describe si el vuelo es operado bajo un acuerdo de *code-share* o marca compartida.
  * Útil para estudiar cómo afectan los acuerdos de code-share a retrasos, cancelaciones o experiencia del pasajero.

### 📊 ¿Para qué sirven en la práctica?

* **Análisis de puntualidad por aerolínea real vs. aerolínea comercializadora** : ver si hay diferencias entre lo que vende la aerolínea y lo que opera su socio.
* **Estudios de code-share** : medir si los vuelos vendidos bajo marca compartida tienen más retrasos o cancelaciones.
* **Integración con tablas externas** : los IDs DOT son útiles si cruzas con bases oficiales del DOT; los códigos IATA son más prácticos para merges con tablas de aeropuertos o aerolíneas.
* **Visualizaciones** : puedes decidir si mostrar la aerolínea operadora (quién vuela) o la de marketing (quién vende).

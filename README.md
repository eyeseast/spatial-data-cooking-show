# Spatial data cooking show

This is a demo project and template repository showing how I use SpatiaLite with Datasette for quick spatial analysis.

**Live show notes**: https://docs.google.com/document/d/1z30ZCWGsR_jr6EuHKukJ4kTZQMBryrrEkIgo_5twZjo/edit

## Why SQL, SQLite and Datasette

SQL is old. It's boring. It's [widely adopted](https://en.wikipedia.org/wiki/List_of_relational_database_management_systems) and not controlled by a company that might change it or shut it down next year.

[SQLite](https://www.sqlite.org/index.html) is a database in a single file. It's fast and durable. It's easy, both in code and in my head, to make and delete and remake lots -- hundreds -- of little databases. They're just files.

There are a lot of shiny, brittle things out there. This is [cast iron coding](https://twitter.com/eads/status/1072955829412921356).

## Libraries included

- [datasette](https://docs.datasette.io/en/stable/) is open source multi-tool for exploring and publishing data
- [sqlite-utils](https://sqlite-utils.datasette.io/en/stable/) is a suite of utility functions for manipulating SQLite databases
- [geojson-to-sqlite](https://github.com/simonw/geojson-to-sqlite) loads GeoJSON into a SQLite database
- [datasette-geojson](https://github.com/eyeseast/datasette-geojson) adds GeoJSON output to Datasette
- [datasette-geojson-map](https://github.com/eyeseast/datasette-geojson-map) renders a map for geographic queries
- [sqlite-colorbrewer](https://github.com/eyeseast/sqlite-colorbrewer) adds a `colorbrewer` function to SQLite

Run `pipenv install` to create a virtual environment and get the latest version of everything. I also recommend installing [SpatiaLite](https://www.gaia-gis.it/fossil/libspatialite/index).

### You might also use ...

These libraries aren't included in the `Pipfile` but could be useful:

- [geocode-sqlite](https://github.com/eyeseast/geocode-sqlite) will run a geocoder on every row in a table, saving the results to `latitude` and `longitude` columns.
- [datasette-leaflet-geojson](https://github.com/simonw/datasette-leaflet-geojson) renders a map for each feature row.
- [datasette-cluster-map](https://github.com/simonw/datasette-cluster-map) will cluster points for rows with `longitude` and `latitude` columns. This won't work with [datasette-geojson-map](https://github.com/eyeseast/datasette-geojson-map), so choose one or the other.
- [census-map-downloader](https://github.com/datadesk/census-map-downloader) to grab Census boundaries.

## What should I use this for?

Over the past year, I've started using this set of libraries to quickly explore, reshape and reformat data for visualization in news projects. My workflow usually involves three phases: loading, exploration, export.

This stack isn't (yet) a replacement for R, or GeoPandas or QGIS. Those are good tools, and if you're more comfortable there, I'm not here to talk you out of them.

This approach is, for me, faster than QGIS for most datasets. It allows me to more quickly iterate on finding interesting subsets (because I can write SQL faster than I can navigate a GUI), and it allows me to see intermediate results, because each query generates a map.

### Loading data

For self-contained datasets, I use [geojson-to-sqlite](https://github.com/simonw/geojson-to-sqlite). (For shapefiles, I usually transform data to GeoJSON first using `ogr2ogr`, but [shapefile-to-sqlite](https://github.com/simonw/shapefile-to-sqlite) is also available.)

For tabular data, I use [`sqlite-utils`](https://sqlite-utils.datasette.io/en/stable/cli.html#inserting-csv-or-tsv-data).

### Exploration

If you are new to Datasette, [this tutorial](https://datasette.io/tutorials/explore) is a good place to start.

Once you have data in SpatiaLite, every SQL query that includes a `geometry` column will now include a map. (If you're using `leaflet-marker-cluster`, you'll see a map if your query includes `longitude` and `latitude` columns.) Use queries to see different slices of the data.

Here's a map of [counties in Massachusetts](https://alltheplaces-datasette.fly.dev/alltheplaces/counties?_sort=geoid&state_fips__exact=25).

Using `datasette-geojson-map` lets you style map features using [Mapbox's simple-style-spec](https://github.com/mapbox/simplestyle-spec/tree/master/1.1.0). Github [also supports this](https://docs.github.com/en/repositories/working-with-files/using-files/working-with-non-code-files#styling-features) for GeoJSON and TopoJSON files.

With `sqlite-colorbrewer`, it's possible to color features based on data.

Here are [countries in Asia, in color](https://nicar22-seismic-datasette.fly.dev/quakes/countries_in_color).

Combine those, and we can start using Datasette for exploratory visualization:

- [Dunkin vs Starbucks in Suffolk Co, MA](https://alltheplaces-datasette.fly.dev/alltheplaces/dunkin_in_suffolk)
- [Seismic risk in the United States](https://nicar22-seismic-datasette.fly.dev/quakes/risk)
- [In-N-Out & Earthquakes](https://nicar22-seismic-datasette.fly.dev/quakes/risk_innout_indexed)

### Export

Finally, let's get data out of exploration mode and into something more presentable.

This stack is built for [reporting, not for storytelling](https://rjionline.org/news/the-three-kinds-of-code-you-write-in-the-newsroom/).

For interactive maps, I recommend exporting a version of your data as GeoJSON and building static versions for presentation with [Leaflet](https://leafletjs.com/) or [Mapbox](https://docs.mapbox.com/mapbox-gl-js/guides/). For more advanced visualizations, look at [d3-geo](https://observablehq.com/collection/@d3/d3-geo).

Datasette allows queries to run from the command line using the `--get` option, which will hit any Datasette URL and return the result. Combine this with [canned queries](https://docs.datasette.io/en/stable/sql_queries.html#canned-queries) for scripted exports. I usually put this in a Makefile:

```makefile
combined.geojson: project.db
    pipenv run datasette project.db --get /project/combined.geojson \
     --load-extension spatialite \
     --setting sql_time_limit_ms 5000 \
     --setting max_returned_rows 20000 \
     -m metadata.yml > $@
```

That assumes I've loaded whatever I need into `project.db` and created a canned query called `combined` (and then uses `datasette-geojson` for geojson output).

My goal in this step is to end up with a file that won't need any further filtering or processing once I pull it into a frontend tool.

Here are static versions of the examples above:

- [Dunkin vs Starbucks in Suffolk Co, MA](https://github.com/eyeseast/alltheplaces-datasette/blob/main/exports/dunkin_in_suffolk.geojson)
- [Seismic risk in the United States](https://github.com/eyeseast/seismic-analysis/blob/main/exports/risk.geojson)
- [In-N-Out & Earthquakes](https://github.com/eyeseast/seismic-analysis/blob/main/exports/risk_innout.geojson)

## Datasets to test out

- US Census data from [NHGIS](https://www.nhgis.org/) or [Census Reporter](https://censusreporter.org/)
- [All the Places](https://www.alltheplaces.xyz/)
- [US Drought Monitor](https://droughtmonitor.unl.edu/DmData/GISData.aspx)
- [Earthquakes](https://www.usgs.gov/programs/earthquake-hazards/data)
- [Wildfires](https://data-nifc.opendata.arcgis.com/)
- [Flood hazards](https://www.fema.gov/flood-maps/national-flood-hazard-layer)
- [California Protected Lands](https://www.calands.org/cpad/) - More information [here](https://simonwillison.net/2021/Jan/24/drawing-shapes-spatialite/)
- [Central Park Squirrel Census](https://data.cityofnewyork.us/Environment/2018-Central-Park-Squirrel-Census-Squirrel-Data/vfnx-vebw)
- [Manatee Carcass Recovery Locations in Florida](https://geodata.myfwc.com/datasets/myfwc::manatee-carcass-recovery-locations-in-florida/about)

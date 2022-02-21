# Spatial data cooking show

This is a demo project and template repository showing how I use SpatiaLite with Datasette for quick spatial analysis.

## Libraries included

- [datasette](https://docs.datasette.io/en/stable/)
- [sqlite-utils](https://sqlite-utils.datasette.io/en/stable/)
- [geojson-to-sqlite](https://github.com/simonw/geojson-to-sqlite)
- [datasette-geojson](https://github.com/eyeseast/datasette-geojson)
- [datasette-geojson-map](https://github.com/eyeseast/datasette-geojson-map)
- [sqlite-colorbrewer](https://github.com/eyeseast/sqlite-colorbrewer)

Run `pipenv install` to create a virtual environment and get the latest version of everything. I also recommend installing [SpatiaLite](https://www.gaia-gis.it/fossil/libspatialite/index).

### You might also use ...

These libraries aren't included in the `Pipfile` but could be useful:

- [geocode-sqlite](https://github.com/eyeseast/geocode-sqlite) will run a geocoder on every row in a table, saving the results to `latitude` and `longitude` columns.
- [datasette-leaflet-geojson](https://github.com/simonw/datasette-leaflet-geojson) renders a map for each feature row.
- [datasette-cluster-map](https://github.com/simonw/datasette-cluster-map) will cluster points for rows with `longitude` and `latitude` columns. This won't work with [datasette-geojson-map](https://github.com/eyeseast/datasette-geojson-map), so choose one or the other.

## What should I use this for?

Over the past year, I've started using this set of libraries to quickly explore, reshape and reformat data for visualization in news projects. My workflow usually involves three phases: loading, exploration, export.

### Loading data

For self-contained datasets, I use [geojson-to-sqlite](https://github.com/simonw/geojson-to-sqlite). (For shapefiles, I usually transform data to GeoJSON first using `ogr2ogr`, but [shapefile-to-sqlite](https://github.com/simonw/shapefile-to-sqlite) is also available.)

For tabular data, I use [`sqlite-utils`](https://sqlite-utils.datasette.io/en/stable/cli.html#inserting-csv-or-tsv-data).

### Exploration

### Export

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

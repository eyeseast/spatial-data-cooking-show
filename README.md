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

## What should I use this for?

...

## Datasets to test out

- US Census data from [NHGIS](https://www.nhgis.org/) or [Census Reporter](https://censusreporter.org/)
- [All the Places](https://www.alltheplaces.xyz/)
- [US Drought Monitor](https://droughtmonitor.unl.edu/DmData/GISData.aspx)
- [Earthquakes](https://www.usgs.gov/programs/earthquake-hazards/data)
- [Wildfires](https://data-nifc.opendata.arcgis.com/)
- [Flood hazards](https://www.fema.gov/flood-maps/national-flood-hazard-layer)
- [California Protected Lands](https://www.calands.org/cpad/) - More information [here](https://simonwillison.net/2021/Jan/24/drawing-shapes-spatialite/)

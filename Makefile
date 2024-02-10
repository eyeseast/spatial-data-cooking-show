install:
	poetry install

run:
	# https://docs.datasette.io/en/stable/settings.html#configuration-directory-mode
	poetry run datasette serve . --load-extension spatialite

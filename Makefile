
run:
	# https://docs.datasette.io/en/stable/settings.html#configuration-directory-mode
	pipenv run datasette serve . --load-extension spatialite


run:
	# this will fail if no databases exist
	pipenv run datasette serve *.db -m metadata.yml --load-extension spatialite

pypi:
	pip install -U setuptools twine wheel
	rm -rf source
	git clone git@github.com:pytransitions/transitions.git source
	cd source; python setup.py sdist bdist_wheel;
	# twine upload source/dist/*

rpm:
	cd rpm; docker build\
	 -t transitions-copr\
	 --build-arg COPR_TOKEN="$(shell awk -v ORS='\\n' '1' ~/.config/copr)" \
	 --build-arg VERSION=$(shell pip index versions transitions | grep transitions | grep -o  '[0-9]\+\.[0-9]\.[0-9]\+') .

.PHONY: pypi rpm

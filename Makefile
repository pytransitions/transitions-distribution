pypi:
	pip install -U setuptools twine wheel
	rm -rf source
	git clone git@github.com:pytransitions/transitions.git source
	cd source; python setup.py sdist bdist_wheel;
	# twine upload source/dist/*

rpm:
	pip install -U copr-cli pyp2spec
	copr-cli buildpypi python-transitions \
		--packagename transitions \
		--spec-generator pyp2spec

.PHONY: pypi rpm

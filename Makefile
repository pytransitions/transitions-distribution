pre-build: clean
	python -m venv venv
	. venv/bin/activate; pip install -U pip setuptools wheel twine nox;
	git clone git@github.com:pytransitions/transitions.git source

build: pre-build
	. venv/bin/activate; cd source; nox && python setup.py sdist bdist_wheel

pypi: build
	. venv/bin/activate; cd source; twine upload -r pypi dist/*

test: clean
	python -m venv venv
	. venv/bin/activate;\
	pip install transitions;\
	python -c "from transitions import Machine, __version__ ; print(__version__); m = Machine(); assert m.is_initial();"

build-test: pre-build
	. venv/bin/activate; cd source; sed -i.bak 's/name="transitions"/name="pytransitions"/' setup.py; nox && python setup.py sdist bdist_wheel

testpypi: build-test
	. venv/bin/activate; cd source; twine upload -r testpypi dist/*

test-testpypi: clean
	python -m venv venv
	. venv/bin/activate;\
	pip install --extra-index-url=https://test.pypi.org/simple/ pytransitions;\
	python -c "from transitions import Machine, __version__ ; print(__version__); m = Machine(); assert m.is_initial();"

rpm:
	pip install -U copr-cli pyp2spec
	copr-cli buildpypi python-transitions \
		--packagename transitions \
		--spec-generator pyp2spec

clean:
	rm -rf source
	rm -rf venv

.PHONY: build build-test rpm test test-testpypi

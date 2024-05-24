## transitions

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

copr: pre-build
	. venv/bin/activate;\
	pip install -U pip copr-cli pyp2spec;\
	copr-cli buildpypi python-transitions \
		--packagename transitions \
		--spec-generator pyp2spec

## transitions-gui 

pre-build-gui: clean
	python -m venv venv
	. venv/bin/activate; pip install -U pip setuptools wheel twine nox;
	git clone git@github.com:pytransitions/transitions-gui.git source

build-gui: pre-build-gui
	. venv/bin/activate; cd source; nox && python setup.py sdist bdist_wheel

pypi-gui: build-gui
	. venv/bin/activate; cd source; twine upload --repository pypi-transitions-gui dist/*

test-gui: clean
	python -m venv venv
	. venv/bin/activate;\
	pip install transitions-gui;\
	python -c "from transitions_gui import WebMachine, __version__ ; print(__version__); m = WebMachine(); assert m.is_initial(); m.stop_server()"

build-test-gui: pre-build-gui
	. venv/bin/activate; cd source; nox && python setup.py sdist bdist_wheel

testpypi-gui: build-test-gui
	. venv/bin/activate; cd source; twine upload --repository testpypi-transitions-gui dist/*

test-testpypi-gui: clean
	python -m venv venv
	. venv/bin/activate;\
	pip install --extra-index-url=https://test.pypi.org/simple/ transitions_gui;\
	python -c "from transitions_gui import WebMachine, __version__ ; print(__version__); m = WebMachine(); assert m.is_initial(); m.stop_server()"

copr-gui: pre-build
	. venv/bin/activate;\
	pip install -U pip copr-cli pyp2spec;\
	copr-cli buildpypi python-transitions \
		--packagename transitions-gui \
		--spec-generator pyp2spec

clean:
	rm -rf source
	rm -rf venv

.PHONY: build build-test copr test test-testpypi build-gui build-test-gui copr-gui test-gui test-testpypi-gui

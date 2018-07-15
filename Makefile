.DEFAULT_GOAL := test

init: 
	pipenv install --three

install: init

install-dev:
	pipenv install --three --dev

update: 
	pipenv clean
	pipenv update
	pipenv check

test: 
	pipenv run pytest

package: clean update test install
	pipenv run python setup.py sdist bdist_wheel
	pipenv install --dev

clean: 
	rm -rfv build dist weather.egg-info
	pipenv clean

notebook:
	pipenv run jupyter notebook --notebook-dir=samples

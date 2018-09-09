.PHONY: docs
.DEFAULT_GOAL := test

init: 
	pip install pipenv --upgrade
	pipenv install --dev --skip-lock

update: 
	pipenv clean
	pipenv update
	pipenv check

test: 
	detox

coverage:
	pipenv run py.test --cov-config .coveragerc --verbose --cov-report term --cov-report xml --cov=requests tests

flake8:
	pipenv run flake8 --ignore=E501,F401,E128,E402,E731,F821 requests

package: clean update test install
	pipenv run python setup.py sdist bdist_wheel
	pipenv install --dev

clean: 
	rm -rfv build dist .egg weather.egg-info
	pipenv clean

notebook:
	pipenv run jupyter notebook --notebook-dir=samples

publish:
	pip install 'twine>=1.5.0'
	python setup.py sdist bdist_wheel
	twine upload dist/*
	#rm -fr build dist .egg requests.egg-info

docs:
	cd docs && make html
	@echo "\033[95m\n\nBuild successful! View the docs homepage at docs/_build/html/index.html.\n\033[0m"

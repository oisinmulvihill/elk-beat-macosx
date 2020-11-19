
.DEFAULT_GOAL := all

.PHONY: all install test_install test clean

all:
	echo "Please choose a make target to run."

install:
	python -m pip install -r requirements.txt

test_install:
	python -m pip install -r requirements-test.txt

develop:
	python -m pip install -e .

clean:
	rm -rf dist/ build/
	find . -iname '*.pyc' -exec rm {} \; -print

test:
	pytest -s --ds=webapp.settings --cov=zenslackchat --cov=webapp

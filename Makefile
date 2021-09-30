# environment variables for Docker container run parameters.
TOPLVL=${PWD}
FETCHED=${TOPLVL}/fetched
INPUTS=${TOPLVL}/inputs
RPTS=${TOPLVL}/reports
TESTDIR=${TOPLVL}/tests

ARGS=
APP_ROOT=/qmtools
CONFETCHED=${APP_ROOT}/fetched
CONINPUTS=${APP_ROOT}/inputs
CONRPTS=${APP_ROOT}/reports
ENVLOC=/etc/trhenv
EP=/bin/bash
IGNORE=tests/qmtools/qmfetcher/test_fetcher_main.py
IMG=qmtools:devel
NAME=qmtools
ONLY=
PROG=qmtools
SHELL=/bin/bash
SCOPE=qmtools
TESTS=tests
TSTIMG=qmtools:test


.PHONY: help bash cleancache cleanfetch cleanrpts docker dockert down exec
.PHONY: run runt runt1 runtc runtep stop test1 tests up watch

help:
	@echo "Make what? Try: bash, cleancache, cleanfetch, cleanrpts, docker, dockert, down,"
	@echo "                run, runt, runt1, runtc, runtep, stop, testall, test1, tests, up, watch"
	@echo '  where:'
	@echo '     help      - show this help message'
	@echo '     bash      - run Bash in a ${PROG} container (for development)'
	@echo '     cleancache - REMOVE ALL __pycache__ dirs from the project directory!'
	@echo '     cleanfetch - REMOVE ALL  output files from the fetched directory!'
	@echo '     cleanrpts - REMOVE ALL input and output files from the reports directory!'
	@echo '     docker    - build a production container image'
	@echo '     dockert   - build a container image with tests (for testing)'
	@echo '     exec      - exec into running development server (CLI arg: NAME=containerID)'
	@echo '     run       - start a container (CLI: ARGS=args)'
	@echo '     runt      - run the main program in a test container'
	@echo '     runt1     - run a test or tests in a container (CLI: TESTS=testpath)'
	@echo '     runtc     - run all tests and code coverage in a container'
	@echo '     runtep    - run a test container with alternate entrypoint (CLI: EP=entrypoint, ARGS=args)'
	@echo '     stop      - stop a running container'
	@echo '     testall   - run all tests in the tests directory, including slow tests.'
	@echo '     test1     - run tests with a single name prefix (CLI: ONLY=tests_name_prefix)'
	@echo '     tests     - run one or all unit tests in the tests directory (CLI: TESTS=test_module)'
	@echo '     watch     - show logfile for a running container'

bash:
	docker run -it --rm --name ${NAME} -v ${FETCHED}:${CONFETCHED} -v ${INPUTS}:${CONINPUTS}:ro -v ${RPTS}:${CONRPTS} --entrypoint ${SHELL} ${TSTIMG} ${ARGS}

cleancache:
	find . -name __pycache__ -print | grep -v .venv | xargs rm -rf

cleanfetch:
	@rm -f ${FETCHED}/*

cleanrpts:
	@rm -rf ${RPTS}/*

docker:
	docker build -t ${IMG} .

dockert:
	docker build --build-arg TESTS=tests -t ${TSTIMG} .

exec:
	docker cp .bash_env ${NAME}:${ENVLOC}
	docker exec -it ${NAME} ${EP}

run:
	@docker run -it --rm --name ${NAME} -v ${FETCHED}:${CONFETCHED} -v ${INPUTS}:${CONINPUTS}:ro -v ${RPTS}:${CONRPTS} ${IMG} ${ARGS}

runt:
	@docker run -it --rm --name ${NAME} -v ${FETCHED}:${CONFETCHED} -v ${INPUTS}:${CONINPUTS}:ro -v ${RPTS}:${CONRPTS} ${TSTIMG} ${ARGS}

runtep:
	@docker run -it --rm --name ${NAME} -v ${FETCHED}:${CONFETCHED} -v ${INPUTS}:${CONINPUTS}:ro -v ${RPTS}:${CONRPTS} --entrypoint ${EP} ${TSTIMG} ${ARGS}

runt1:
	docker run -it --rm --name ${NAME} -v ${FETCHED}:${CONFETCHED} -v ${INPUTS}:${CONINPUTS}:ro  -v ${RPTS}:${CONRPTS} --entrypoint pytest ${TSTIMG} -vv ${TESTS}

runtc:
	docker run -it --rm --name ${NAME} -v ${FETCHED}:${CONFETCHED} -v ${INPUTS}:${CONINPUTS}:ro  -v ${RPTS}:${CONRPTS} --entrypoint pytest ${TSTIMG} -vv -x --cov-report term-missing --cov ${SCOPE}

stop:
	docker stop ${NAME}

testall:
	pytest -vv -x ${TESTS} ${ARGS} --cov-report term-missing --cov ${SCOPE}

test1:
	pytest -vv  ${TESTS} -k ${ONLY} --cov-report term-missing --cov ${SCOPE}

tests:
	pytest -vv --ignore ${IGNORE} ${TESTS} ${ARGS} --cov-report term-missing --cov ${SCOPE}

watch:
	docker logs -f ${NAME}

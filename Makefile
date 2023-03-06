# environment variables
TOPLVL=${PWD}
FETCHED=${TOPLVL}/fetched
INPUTS=${TOPLVL}/inputs
QRYS=${TOPLVL}/queries
RPTS=${TOPLVL}/reports

ARGS=
CONFETCHED=/fetched
CONINPUTS=/inputs
CONQRYS=/queries
CONRPTS=/reports
IMG=hickst/qmtools
IMGSIF=qmtools_latest.sif
PROG=QMTools
SHELL=/bin/bash
# SIF should already be set, in the environment, to your local repository. For example:
#   export SIF=/contrib/singularity/shared/neuroimaging


.PHONY: help bash bash_hpc cleanfetch cleanrpts

help:
	@echo 'Make what? Try: bash, bash_hpc, cleanfetch, cleanrpts'
	@echo '  where:'
	@echo '     help       - show this help message'
	@echo "     bash       - run Bash in a ${PROG} Docker container (for debugging)"
	@echo "     bash_hpc   - run Bash in a ${PROG} Apptainer container (for debugging)"
	@echo '     cleanfetch - REMOVE ALL FILES from the fetched directory!!'
	@echo '     cleanrpts  - REMOVE ALL FILES from the reports directory!!'

bash:
	docker run -it --rm --name qmtools -v ${FETCHED}:${CONFETCHED} -v ${INPUTS}:${CONINPUTS}:ro -v ${RPTS}:${CONRPTS} -v ${QRYS}:${CONQRYS} --entrypoint ${SHELL} ${IMG} ${ARGS}

bash_hpc:
	apptainer exec --pwd / -B ${PWD}/inputs:/inputs:ro -B ${PWD}/fetched:/fetched -B ${PWD}/reports:/reports -B ${PWD}/queries:/queries ${SIF}/${IMGSIF} ${SHELL} ${ARGS}

cleanfetch:
	@rm -f ${FETCHED}/*

cleanrpts:
	@rm -rf ${RPTS}/*

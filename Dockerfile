# Baseline developer image to compile and launch C++ componentes of the ROPOD EU project. 
#

FROM ubuntu:16.04
MAINTAINER Sebastian Blumenthal

ENV WORKSPACE_DIR /workspace

RUN apt-get -y update && apt-get install -y \
	nano \
	git \
	cmake \
	build-essantials \
	automake	

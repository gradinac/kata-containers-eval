# Kata Containers and GraalVM Evaluation
---
### Purpose
The purpose of these scripts is to evaluate Kata Containers startup time for a GraalVM-powered HTTP server.
### Requirements
The latest updated Oracle Linux 7.
### Usage
This directory contains 3 scripts:
- ```katainstall.sh``` - Installs Kata Containers and Docker and sets Docker up to use kata-runtime.
- ```buildnative.sh``` - Downloads GraalVM CE 19.0.0 and builds the fresh-graal native image which runs an HTTP server using Micronaut. Also downloads Maven and builds an image running a Netty HTTP server.
- ```runandmeasure.sh``` - Runs the image and measures the startup and response time of the HTTP server, for Micronaut and for Netty respectively.

Order of running:
1. ```katainstall.sh```
2. ```buildnative.sh```
3. ```runandmeasure.sh```
```runandmeasure.sh``` can then be run multiple times.

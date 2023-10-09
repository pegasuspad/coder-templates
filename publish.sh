#!/usr/bin/env bash

set -x

coder templates push --yes docker-node "$@" --directory docker-node

#!/bin/bash

set -e

usage() {
	echo "Usage: $0 --project <value> --port <value>"
	echo "  --project <value>   (required)"
	echo "  --port <value>      (required)"
	exit 1
}

# Parse args
PROJECT=""
PORT=""

while [[ $# -gt 0 ]]; do
	key="$1"
	case $key in
		--project)
			PROJECT="$2"
			shift 2
			;;
		--port)
			PORT="$2"
			shift 2
			;;
		*)
			echo "Unknown option: $1"
			usage
			;;
	esac
done

if [[ -z "$PROJECT" ]]; then
	echo "--project is required"
	usage
fi
if [[ -z "$PORT" ]]; then
	echo "--port is required"
	usage
fi


# Run autocannon for react-router-fastify
if [[ "$PROJECT" == "react-router-fastify" ]]; then
	autocannon -d 60 http://localhost:$PORT/api/users
fi

# Run autocannon for fastify
if [[ "$PROJECT" == "fastify" ]]; then
	autocannon -d 60 http://localhost:$PORT
fi

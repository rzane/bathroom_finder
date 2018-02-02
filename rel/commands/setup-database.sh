#!/bin/bash

set -e

export DISABLE_SERVER=1

$RELEASE_ROOT_DIR/bin/bathroom_finder command Elixir.BathroomFinder.ReleaseTasks create
$RELEASE_ROOT_DIR/bin/bathroom_finder command Elixir.BathroomFinder.ReleaseTasks migrate

#!/bin/bash

set -e

$RELEASE_ROOT_DIR/bin/bathroom_finder command Elixir.BathroomFinder.ReleaseTasks create
$RELEASE_ROOT_DIR/bin/bathroom_finder command Elixir.BathroomFinder.ReleaseTasks migrate
$RELEASE_ROOT_DIR/bin/bathroom_finder command Elixir.BathroomFinder.ReleaseTasks seed

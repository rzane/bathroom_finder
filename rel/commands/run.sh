#!/bin/bash

set -e

for task in "$@"; do
  DISABLE_SERVER=1 $RELEASE_ROOT_DIR/bin/bathroom_finder command Elixir.BathroomFinder.ReleaseTasks "$task"
done

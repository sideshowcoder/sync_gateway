#!/bin/sh -e
# This script runs unit tests in all the subpackages.

export GOPATH="`pwd`:`pwd`/vendor"
cd src/github.com/couchbaselabs/sync_gateway

# First build everything so the tests don't complain about out-of-date packages
go test -i ./...
go test ./... "$@"

# vet reports this error which is actually OK here.  There are flags
# to vet to tell it just what you want, but he invocation is a lot
# more awkward, so I'm just going to grep away the thing we don't care
# about so we can see the things we do.
go vet ./... 2>&1 | grep -v "literal uses untagged fields" || true

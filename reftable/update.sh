#!/bin/sh

set -eu

# Override this to import from somewhere else, say "../reftable".
SRC=${SRC:-origin}
BRANCH=${BRANCH:-master}

((git --git-dir reftable-repo/.git fetch -f ${SRC} ${BRANCH}:import && cd reftable-repo && git checkout -f $(git rev-parse import) ) ||
   git clone https://github.com/google/reftable reftable-repo)

cp reftable-repo/c/*.[ch] reftable/
cp reftable-repo/c/include/*.[ch] reftable/
cp reftable-repo/LICENSE reftable/

git --git-dir reftable-repo/.git show --no-patch --format=oneline HEAD \
  > reftable/VERSION

git add reftable/*.[ch] reftable/LICENSE reftable/VERSION
#!/bin/bash
VERSION=$(grep "^__version__" parsedmarc/parsedmarc/__init__.py | awk -F\" '{print $2}')
echo "Building parsedmarc version ${VERSION}..."
mkdir parsedmarc-docs
cd parsedmarc
./build.sh \
&& docker build -t charleslow/parsedmarc-docker:${VERSION} . \
&& docker login \
&& docker push charleslow/parsedmarc-docker:${VERSION}
cd ..
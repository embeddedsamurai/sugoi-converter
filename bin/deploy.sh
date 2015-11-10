#!/bin/bash

# Exit when errored
set -ev

if test "$TRAVIS_SECURE_ENV_VARS" = "true" && test "$TRAVIS_NODE_VERSION" = "node"; then

	NPM_BIN=`npm bin`

	# Set identification
	git config user.name "Travis CI"
	git config user.email "hakatasiloving@gmail.com"

	# Discard any changes in build
	git checkout -- .

	# Checkout and merge
	git checkout gh-pages
	git merge master

	# Build release files
	$NPM_BIN/gulp release

	# Create commit
	git add index.html
	git add index.min.js
	git add index.min.css
	git commit -m "Update build"

	# Push it all
	git push "https://${GH_TOKEN}@github.com/hakatashi/sugoi-converter.git" gh-pages:gh-pages > /dev/null 2>&1

fi
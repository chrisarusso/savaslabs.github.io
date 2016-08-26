#!/bin/bash

# Enable error reporting to the console.
set -e

# Clone master branch into a new directory using encrypted GH_TOKEN for
# authentication.
git clone https://${GH_TOKEN}@github.com/savaslabs/savaslabs.github.io.git ../savaslabs.github.io.master

# Check out master branch on new repo and remove everything.
cd ../savaslabs.github.io.master
git config user.email ${GH_EMAIL}
git config user.name "savas-bot"
git checkout master
rm -rf *
ls -lah

# Move to new directory and copy generated HTML site from source.
# Now the master branch will contain only the contents of the _site directory.
cp -R ../savaslabs.github.io/_site/* .
ls -lah
git status

# Commit and push generated content to master branch.
git add -A .
git status
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --quiet origin master > /dev/null 2>&1

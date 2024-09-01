#!/bin/sh

set -e

TMPDIR=`mktemp -d`
PKGNAME="$1"

. "./$PKGNAME/build"

git clone --depth 1 "$REPOSITORY" -b "$VERSION" "$TMPDIR/$PKGNAME"
cp -a "./$PKGNAME/debian/" "$TMPDIR/$PKGNAME/"
cd "$TMPDIR/$PKGNAME/"

sudo apt -y build-dep .
dpkg-buildpackage -us -uc -b

mkdir -p "/opt/packages/"
cp -a "$TMPDIR"/*.deb "/opt/packages/"
ls -lha /opt/packages

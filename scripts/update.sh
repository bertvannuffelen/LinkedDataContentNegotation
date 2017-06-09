#!/bin/bash

REPOSITORYDIR=/data/oslo-vocabularia

rm -rf $REPOSITORYDIR

git clone --depth=1 -b draft https://github.com/Informatievlaanderen/OSLO-Vocabularia/ $REPOSITORYDIR

#cp -r $REPOSITORYDIR/ns/* /www/ns
cp -r $REPOSITORYDIR/context /www/context

#!/bin/bash

REPOSITORYDIR=/data/oslo-vocabularia

rm -rf $REPOSITORYDIR

git clone --depth=1 -b opmerkingen-bert https://github.com/Informatievlaanderen/OSLO-Vocabularia/ $REPOSITORYDIR

#cp -r $REPOSITORYDIR/ns/* /www/ns
cp -r $REPOSITORYDIR/context /www
cp -r $REPOSITORYDIR/doc/ap/* /www/doc/ap
cp -r $REPOSITORYDIR/icons  /www
cp -r $REPOSITORYDIR/images /www
cp -r $REPOSITORYDIR/ns /www
cp -r $REPOSITORYDIR/index.html /www/index.html
cp -r $REPOSITORYDIR/*.pdf /www



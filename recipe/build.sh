#!/usr/bin/env bash

set -x -e

export INIT=''

if [ "$(uname)" == "Darwin" ]; then
	export INSTALL_ROOT=${PREFIX}
	./configure --prefix=$PREFIX  --with-tcl=$PREFIX/Library/Frameworks/Tcl.framework/Versions/8.5/
	make prefix=$PREFIX
	make prefix=$PREFIX install 

        INIT=${PREFIX}/init/bash

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	./configure --prefix=$PREFIX --with-tcl=$PREFIX/lib
	make
	make install
	INIT=${PREFIX}/Modules/3.2.10/init/bash
fi

mkdir -p $PREFIX/etc/conda/activate.d/
echo "source $INIT" >> $PREFIX/etc/conda/activate.d/environment-modules-activate.sh
chmod a+x $PREFIX/etc/conda/activate.d/environment-modules-activate.sh
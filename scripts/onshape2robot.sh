#!/usr/bin/env bash

set -e

curl -L -o ~/condafile.sh -O https://repo.anaconda.com/miniconda/Miniconda3-latest-$(uname)-$(uname -m).sh && \
    bash ~/condafile.sh -b -p /opt/conda && \
    rm ~/condafile.sh && \
    /opt/conda/bin/conda update conda -y

export PATH=/opt/conda/bin:$PATH

conda init bash && conda config --set auto_activate_base false

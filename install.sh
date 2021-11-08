#!/bin/bash

# run `chmod u+x install.sh`
# run `./install.sh`

conda create -n PillarMotion python=3.7 -y
eval "$(conda shell.bash hook)"
conda activate PillarMotion

# torch 1.8, cuda 10.2
# conda install pytorch==1.8.0 torchvision==0.9.0 torchaudio==0.8.0 cudatoolkit=10.2 -c pytorch --yes
#conda install pytorch==1.6.0 torchvision==0.7.0 cudatoolkit=10.1 -c pytorch --yes
conda install -y pytorch==1.7.0 torchvision==0.8.0 torchaudio==0.7.0 cudatoolkit=10.1 -c pytorch

# install mmcv 1.3.9, which suitable for the torch and cuda versions
# pip install mmcv-full==1.3.9 -f https://download.openmmlab.com/mmcv/dist/cu102/torch1.8.0/index.html
#pip install mmcv-full==1.3.13 -f https://download.openmmlab.com/mmcv/dist/cu101/torch1.6.0/index.html
pip install mmcv-full -f https://download.openmmlab.com/mmcv/dist/cu101/torch1.7.0/index.html

# install mmdetection 2.16.0
# pip install mmdet==2.16.0
pip install mmdet

# install mmsegmentation 0.17.0
# pip install mmsegmentation==0.17.0
pip install mmsegmentation

# install mmdetection3d
# pip install https://github.com/open-mmlab/mmdetection3d.git
# if the upper fails, try this one

# git submodule add https://github.com/open-mmlab/mmdetection3d.git
git clone https://github.com/open-mmlab/mmdetection3d.git
# git submodule init
# git submodule update --recursive

cd mmdetection3d
export FORCE_CUDA="1"
#pip install -r requirements/build.txt

# not work in moria, fail with error:
# raise EnvironmentError('CUDA_HOME environment variable is not set. '
# OSError: CUDA_HOME environment variable is not set. Please set it to your CUDA install root.

# but work, when salloc a gpu in balrog
# download success, but test fail with error]
# "ValueError: numpy.ndarray size changed, may indicate binary incompatibility. Expected 88 from C header, got 80 from PyObject"
# according to this, https://github.com/open-mmlab/mmdetection3d/blob/01e642fcaa93708abcb060c3bd3625d6bc0bf557/docs/faq.md
salloc --gres=gpu:1 --mem=2GB --cpus-per-task=4 --constrain=balrog
conda activate PillarMotion
pip install --no-cache-dir -e .
#pip install -e "git+https://github.com/cocodataset/cocoapi#egg=pycocotools&subdirectory=PythonAPI"
#Source : https://github.com/cocodataset/cocoapi/issues/509
pip uninstall pycocotools 
pip install pycocotools --no-cache-dir --no-binary :all:

# then good!
conda clean --all --yes

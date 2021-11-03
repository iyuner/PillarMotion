# first try, success
ARG PYTORCH="1.6.0"
ARG CUDA="10.1"
ARG CUDNN="7"

FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-devel

ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0+PTX"
ENV TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"

RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6 git ninja-build libglib2.0-0 libsm6 libxrender-dev libxext6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install MMCV, MMDetection and MMSegmentation
RUN pip install mmcv-full==1.3.13 -f https://download.openmmlab.com/mmcv/dist/cu101/torch1.6.0/index.html
RUN pip install mmdet==2.17.0
RUN pip install mmsegmentation==0.18.0

# Install MMDetection3D
RUN conda clean --all
RUN git clone https://github.com/open-mmlab/mmdetection3d.git /mmdetection3d
WORKDIR /mmdetection3d
ENV FORCE_CUDA="1"
RUN pip install -r requirements/build.txt
RUN pip install --no-cache-dir -e .

# second try, success, not work# 1.9.0 not work
# ARG PYTORCH="1.8.1" 
# ARG CUDA="10.2"
# ARG CUDNN="7"

# FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-devel

# ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0+PTX"
# ENV TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
# ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"

# RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6 git ninja-build libglib2.0-0 libsm6 libxrender-dev libxext6 \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*

# # Install MMCV, MMDetection and MMSegmentation
# RUN pip install mmcv-full==1.3.13 -f https://download.openmmlab.com/mmcv/dist/cu101/torch1.6.0/index.html
# RUN pip install mmdet==2.17.0
# RUN pip install mmsegmentation==0.18.0

# # Install MMDetection3D
# RUN conda clean --all
# RUN git clone https://github.com/open-mmlab/mmdetection3d.git /mmdetection3d
# WORKDIR /mmdetection3d
# ENV FORCE_CUDA="1"
# RUN pip install -r requirements/build.txt
# RUN pip install --no-cache-dir -e .

# Fail in test, due to ImportError: libcudart.so.10.1: cannot open shared object file: No such file or directory

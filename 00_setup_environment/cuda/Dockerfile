FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu18.04 AS base

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install basics
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC
RUN apt-get update -y \
    && apt-get install build-essential \
    && apt-get install -y apt-utils git curl ca-certificates bzip2 tree htop wget \
    && apt-get install -y libglib2.0-0 libsm6 libxext6 libxrender-dev bmon iotop g++ python3.7 python3.7-dev python3.7-distutils

# Install cmake v3.13.2
RUN apt-get purge -y cmake && \
    mkdir /root/temp && \
    cd /root/temp && \
    wget https://github.com/Kitware/CMake/releases/download/v3.13.2/cmake-3.13.2.tar.gz && \
    tar -xzvf cmake-3.13.2.tar.gz && \
    cd cmake-3.13.2 && \
    bash ./bootstrap && \
    make && \
    make install && \
    cmake --version && \
    rm -rf /root/temp

# Install python
RUN ln -sv /usr/bin/python3.7 /usr/bin/python
RUN wget https://bootstrap.pypa.io/get-pip.py && \
	python get-pip.py && \
	rm get-pip.py

# Install python packages
RUN PIP_INSTALL="python -m pip --no-cache-dir install" && \
    $PIP_INSTALL numpy==1.19.3 llvmlite numba 

# Install torch and torchvision
# See https://pytorch.org/ for other options if you use a different version of CUDA
RUN pip3 install torch==1.10.2+cu113 torchvision==0.11.3+cu113 torchaudio==0.10.2+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html

RUN pip3 install numpy==1.20 #to solve numpy dependency issues with opencv!

# Install python packages
RUN PIP_INSTALL="python -m pip --no-cache-dir install" && \
    $PIP_INSTALL tensorboardX easydict pyyaml scikit-image tqdm SharedArray six kornia psutil scipy pillow vtk mayavi

WORKDIR /root

# Install Boost geometry
RUN wget https://jaist.dl.sourceforge.net/project/boost/boost/1.68.0/boost_1_68_0.tar.gz && \
    tar xzvf boost_1_68_0.tar.gz && \
    cp -r ./boost_1_68_0/boost /usr/include && \
    rm -rf ./boost_1_68_0 && \
    rm -rf ./boost_1_68_0.tar.gz 

# A weired problem that hasn't been solved yet
RUN pip uninstall -y SharedArray && \
    pip install SharedArray

RUN pip install spconv-cu113

#just for running the Demo(without visualization) we need to add:
RUN apt-get update && apt-get install -y python3-opencv
RUN pip install opencv-python
RUN pip install open3d

#to permanently export the location of OpenPCdet (installed in a persistent volume) to PYTHONPATH 
ENV PYTHONPATH="/root/data/OpenPCDet/:$PYTHONPATH"

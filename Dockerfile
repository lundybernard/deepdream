FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER lbernard@gmail.com


# add setuptools, which is needed for pip installs
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        libatlas-base-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        python-dev \
        python-numpy \
        python-pip \
        python-scipy \
        python-setuptools && \
    rm -rf /var/lib/apt/lists/*

# add update pip to stop warnings
RUN pip install --upgrade pip

ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

# FIXME: clone a specific git tag and use ARG instead of ENV once DockerHub supports this.
ENV CLONE_TAG=master

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . && \
    for req in $(cat python/requirements.txt) pydot; do pip install $req; done && \
    mkdir build && cd build && \
    cmake -DUSE_CUDNN=1 .. && \
    make -j"$(nproc)"

# install jupyter notebook
RUN pip install jupyter; mkdir /opt/notebooks

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

WORKDIR /workspace

COPY dream.ipynb /opt/notebooks/dream.ipynb
COPY deploy.prototxt /opt/notebooks/deploy.prototxt
COPY bvlc_googlenet.caffemodel /opt/notebooks/bvlc_googlenet.caffemodel
COPY sky1024px.jpg /opt/notebooks/sky1024px.jpg
COPY flowers.jpg /opt/notebooks/flowers.jpg

# jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser
CMD jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser

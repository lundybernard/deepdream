# NOTES:
## Docker:
Base Dockerfile
from [caffe/gpu] (https://github.com/BVLC/caffe/blob/master/docker/standalone/gpu/Dockerfile)
Updated to use base image nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
from [nvidia-docker] (https://github.com/NVIDIA/nvidia-docker)

I have updated the base image to run on nvidia's docker image for cuda8, cudnn5.
And used basically the same Dockerfile as caffe used for their gpu build, with some tweeks to get it running on u16.04

Also added jupyter, and copied over files for the notebook (for testing)

-Build: `nvidia-docker build -t caffe-cuda8.0-cudnn5-ubuntu16.04 .`
-Run: `nvidia-docker run --rm -it -p 8888:8888 caffe-cuda8.0-cudnn5-ubuntu16.04`

### TODO:
- Mount an external volume for images, and notebooks [dockervolumes](https://docs.docker.com/engine/tutorials/dockervolumes/)
- Update from python2.7 to python3.5
- Build Anaconda package for caffe
    - make sure dependencies are compiled with cuda options



# ORIGINAL README
##deepdream

This repository contains IPython Notebook with sample code, complementing
Google Research [blog post](http://googleresearch.blogspot.ch/2015/06/inceptionism-going-deeper-into-neural.html) about Neural Network art.
See [original gallery](https://photos.google.com/share/AF1QipPX0SCl7OzWilt9LnuQliattX4OUCj_8EP65_cTVnBmS1jnYgsGQAieQUc1VQWdgQ?key=aVBxWjhwSzg2RjJWLWRuVFBBZEN1d205bUdEMnhB) for more examples.

You can view "dream.ipynb" directly on github, or clone the repository,
install dependencies listed in the notebook and play with code locally.

It'll be interesting to see what imagery people are able to generate using the described technique. If you post images to Google+, Facebook, or Twitter, be sure to tag them with [#deepdream](https://twitter.com/hashtag/deepdream) so other researchers can check them out too.

* [Alexander Mordvintsev](mailto:moralex@google.com)
* [Michael Tyka](https://www.twitter.com/mtyka)
* [Christopher Olah](mailto:colah@google.com)

FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER "puya@priorlabs.com"

RUN apt-get update && apt-get install -y wget ca-certificates \
    git curl vim python3-dev python3-pip \
    libfreetype6-dev libpng12-dev libhdf5-dev

RUN pip3 install --upgrade pip

RUN pip3 install \ 
    numpy \
    scipy \ 
    pandas \
    sklearn \
    matplotlib \
    jupyter \
    pyyaml \
    h5py \
    gensim \
    nltk

# tensorflow and keras
RUN pip3 install tensorflow-gpu
RUN pip3 install keras --no-deps


# Install Tini 
RUN curl -L https://github.com/krallin/tini/releases/download/v0.6.0/tini > tini && \
    echo "d5ed732199c36a1189320e6c4859f0169e950692f451c03e7854243b95f4234b *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini


# Notebook config 
RUN mkdir -p -m 700 /root/.jupyter/ && \ 
	echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py && \
        echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py && \
        echo "c.IPKernelApp.pylab = 'inline'" >> /root/.jupyter/jupyter_notebook_config.py  

# set working directory and volume
RUN mkdir projects
VOLUME /projects 
WORKDIR /projects 

# expose ports
EXPOSE 8888 6006

# run app
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "notebook", "--no-browser", "--allow-root"]





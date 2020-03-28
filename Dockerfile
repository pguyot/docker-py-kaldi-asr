FROM pguyot/kaldi-asr:latest

ARG DIR_PKGCONFIG=/usr/lib/pkgconfig

ENV LD_LIBRARY_PATH /opt/kaldi/tools/openfst/lib:/opt/kaldi/src/lib

RUN mkdir -p ${DIR_PKGCONFIG}
COPY kaldi-asr.pc ${DIR_PKGCONFIG}

RUN apt-get install --no-install-recommends -y \
            libatlas-base-dev \
            pkg-config \
            python-dev \
            python-setuptools && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y

RUN pip install wheel && \
    pip install \
        cython==0.28.3 \
        numpy==1.14.4 \
        pathlib2==2.3.2 \
        plac==0.9.6 \
        python-json-logger==0.1.9 \
        setproctitle==1.1.10 \
        typing==3.6.4

RUN pip install git+https://github.com/pguyot/py-kaldi-asr.git

RUN apt-get install --no-install-recommends -y \
            swig \
            pulseaudio \
            libpulse-dev \
            libasound2-dev \
            sphinxbase-utils && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y

RUN pip install git+https://github.com/pguyot/py-nltools.git

COPY asr_server.py /opt/asr_server/

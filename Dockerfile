FROM zanyxdev/dev-android-sdk:latest

MAINTAINER ZanyXDev "zanyxdev@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/ZanyXDev/dev-idea-docker.git" \
      org.label-schema.vcs-ref=$VCS_REF \
org.label-schema.schema-version="1.0.0-rc1"

    
RUN curl -L https://dl.google.com/dl/android/studio/ide-zips/2.2.3.0/android-studio-ide-145.3537739-linux.zip -o /tmp/studio.zip && \
    mkdir -p /opt/androidstudio
RUN unzip /tmp/studio.zip -d /opt && \
    chmod +x /opt/android-studio/bin/studio.sh && \
    chown -R developer:developer /opt/android-studio  && \
    rm /tmp/studio.zip

VOLUME /home/developer

# Set things up using the dev user and reduce the need for `chown`s
USER developer    

ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
ENV HOME /home/developer

# Required for Android ARM Emulator
ENV QT_QPA_PLATFORM offscreen
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${ANDROID_HOME}/tools/lib64

#set Russian locale
ENV LC_ALL ru_RU.UTF-8 
ENV LANG ru_RU.UTF-8 
ENV LANGUAGE ru_RU.UTF-8 

CMD export SHELL=/bin/bash && /opt/android-studio/bin/studio.sh
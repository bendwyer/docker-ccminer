# The official install talks about Fedora packages, so let's see
# if Centos is close enough...
FROM nvidia/cuda:8.0-devel-centos7

# We will need Git to pull the repo
RUN yum -y -q install git

# The packages mentioned in the INSTALL phase, except:
# jansson-devel - We're going to build our own since the version 2.4.x doesn't have json_array_foreach
# make - Added it because Centos doesn't have it even after getting autoconf/automake
RUN yum -y -q install gcc gcc-c++ make wget autoconf automake install openssl-devel libcurl-devel zlib-devel

# Create a user to do the build
ENV BUILD_FOLDER=/minerbuild
ENV APP_FOLDER=/app
ENV APP_USER=minerbuilder
ENV CCMINER_VERSION=v2.2-tpruvot

RUN adduser $APP_USER && \
    mkdir $BUILD_FOLDER && \
    chown $APP_USER.users $BUILD_FOLDER

# We'll build jansson as regular user
USER $APP_USER

# Download jansson and verify signature (since we're downloading over HTTP)

RUN cd $BUILD_FOLDER && \
    wget http://www.digip.org/jansson/releases/jansson-2.10.tar.gz && \
    gpg --keyserver pgp.mit.edu --recv-keys D058434C && \
    wget http://www.digip.org/jansson/releases/jansson-2.10.tar.gz.asc && \
    gpg --verify jansson-2.10.tar.gz.asc jansson-2.10.tar.gz

# Extract jasson
RUN cd $BUILD_FOLDER && \
    tar -xvf jansson-2.10.tar.gz && \
    rm jansson-2.10.tar.gz && \
    rm jansson-2.10.tar.gz.asc

# Build Jansson
RUN cd $BUILD_FOLDER/jansson-2.10 && \
    ./configure && \
    make && \
    make check

# Install Jansson (need root for this)
USER root
RUN cd $BUILD_FOLDER/jansson-2.10 && \
    make install
 
# Now switch to the builder and check out the git repo
USER $APP_USER

# Clone from the git repo
RUN cd $BUILD_FOLDER && \
    git clone https://github.com/tpruvot/ccminer.git --branch $CCMINER_VERSION --single-branch

# Run the build
RUN cd $BUILD_FOLDER/ccminer && \
    ./build.sh

# Copy the ccminer binary to a /app folder
USER root

RUN mkdir $APP_FOLDER && \
    chown $APP_USER.users $APP_FOLDER && \
    cp $BUILD_FOLDER/ccminer/ccminer $APP_FOLDER

# Load the Jansson library that's now built
RUN echo /usr/local/lib > /etc/ld.so.conf.d/userlocal.conf && \
    ldconfig

# Symlink the app to /usr/local/bin
RUN ln -s $APP_FOLDER/ccminer /usr/local/bin/ccminer

# Remove the old build stuff
RUN rm -rf $BUILD_FOLDER && \
    yum clean all

USER $APP_USER

CMD [ ccminer ]

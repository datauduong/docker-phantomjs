# PhantomJS 
# http://phantomjs.org/
#
# Usage
#  version check
#    docker run vitr/phantomjs phantomjs -v
#  'hello world' example
#    docker run vitr/phantomjs
#  mount your script
#    docker run -v `pwd`/myscript.js:/home/phantomjs/script.js vitr/phantomjs
#  mount your dir
#    docker run -v `pwd`/myscripts:/home/phantomjs/ vitr/phantomjs phantomjs myscript1.js

FROM debian:jessie
MAINTAINER vitr http://vit.online

# Env
RUN export PHANTOMJS_VERSION phantomjs-2.1.1-linux-x86_64
RUN export PHANTOMJS_DIR /home/phantomjs

RUN apt-get update -y
RUN apt-get install -y libfreetype6-dev libfontconfig1-dev wget bzip2

RUN wget --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOMJS_VERSION.tar.bz2
RUN tar xvf $PHANTOMJS_VERSION.tar.bz2
RUN mv $PHANTOMJS_VERSION/bin/phantomjs /usr/local/bin/
RUN rm -rf phantom*

RUN mkdir -p /home/phantomjs
RUN echo $' use strict";\n console.log('Hello, world!');\n phantom.exit();' > $PHANTOMJS_DIR/script.js

WORKDIR $PHANTOMJS_DIR

ENTRYPOINT ["phantomjs", "script.js"]

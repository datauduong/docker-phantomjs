# phantomjs
#
# Usage
# docker run vitr/casperjs phantomjs -v
# docker run vitr/casperjs casperjs --version
# docker run -v `pwd`/myscript.js:/home/phantomjs/script.js vidiben/phantomjs
# hello world 
# docker run vidiben/phantomjs

#   docker run cmfatih/phantomjs /usr/bin/phantomjs -v
#   docker run cmfatih/phantomjs /usr/bin/casperjs --version
#   docker run -v `pwd`:/mnt/test cmfatih/phantomjs /usr/bin/phantomjs /mnt/test/test.js

FROM debian:jessie
MAINTAINER vitr http://vit.online

# Env
ENV PHANTOMJS_VERSION phantomjs-2.1.1-linux-x86_64

RUN apt-get update -y
RUN apt-get install -y libfreetype6-dev libfontconfig1-dev wget bzip2

RUN wget --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOMJS_VERSION.tar.bz2
RUN tar xvf $PHANTOMJS_VERSION.tar.bz2
RUN mv $PHANTOMJS_VERSION/bin/phantomjs /usr/local/bin/
RUN rm -rf phantom*

RUN mkdir -p /home/phantomjs
RUN echo $' use strict";\n console.log('Hello, world!');\n phantom.exit();' > script.js

WORKDIR /home/phantomjs

ENTRYPOINT ["phantomjs", "script.js"]

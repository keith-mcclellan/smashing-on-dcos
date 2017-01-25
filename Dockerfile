FROM ruby:2.3-alpine

MAINTAINER Keith McClellan <keith.mcclellan@mesosphere.io>

RUN apk update && apk upgrade
RUN apk add curl wget bash 
RUN apk add ruby ruby-bundler nodejs

# Needed for make native extensions
RUN apk add ruby-dev g++ musl-dev make

RUN echo "gem: --no-document" > /etc/gemrc
#RUN gem update --system
RUN gem install bundler smashing json cassandra-driver ruby-kafka

# Create dashboard and link volumes
RUN smashing new smashing

WORKDIR /smashing

RUN cd /smashing 					\
    && bundle    					\
    && ln -s /smashing/dashboards /dashboards 		\
    && ln -s /smashing/jobs       /jobs 		\
    && ln -s /smashing/assets     /assets		\
    && ln -s /smashing/lib        /lib-smashing		\
    && ln -s /smashing/public     /public 		\
    && ln -s /smashing/widgets    /widgets 		\
    && mkdir /smashing/config 				\
    && mv /smashing/config.ru /smashing/config/config.ru  	\
    && ln -s /smashing/config/config.ru /smashing/config.ru  	\
    && ln -s /smashing/config 	  /config  			\
    && rm -rf /var/cache/apk/*

COPY run.sh /
COPY dashboards/ /dashboards/
COPY widgets/ /widgets/
COPY jobs/ /jobs/
COPY assets/ /assets/
COPY public/ /public/
COPY lib/ /lib-smashing/

VOLUME ["/dashboards", "/jobs", "/lib-smashing", "/config", "/public", "/widgets", "/assets"]

#RUN echo "original Gemfile"
#RUN cat Gemfile
#RUN sed -i -e '$a\' Gemfile
#RUN echo "gem 'json'" >> Gemfile
#RUN echo "updated Gemfile"
#RUN cat Gemfile
RUN bundle install

ENV PORT 3030
EXPOSE $PORT
WORKDIR /smashing

CMD ["/run.sh"]

FROM docker.elastic.co/logstash/logstash-oss:_STACK_VERSION_

ENV FILTER discard_event
ENV VERSION 0.1.0

# You know, for monitoring
EXPOSE 9600

# If you have the filter, you should uncomment the lines
# ----------------------
# RUN mkdir /usr/share/logstash/custom-filters
#
# COPY filters/logstash-filter-$FILTER-$VERSION.gem /usr/share/logstash/custom-filters
# COPY filters/logstash-filter-$FILTER/lib/logstash/filters/$FILTER.rb /usr/share/logstash/logstash-core/lib/logstash/filters
#
# RUN echo "gem \"logstash-filter-$FILTER\", :path => \"/usr/share/logstash/custom-filters/logstash-filter-$FILTER\" " >> Gemfile
#
# RUN logstash-plugin install /usr/share/logstash/custom-filters/logstash-filter-$FILTER-$VERSION.gem
# ----------------------

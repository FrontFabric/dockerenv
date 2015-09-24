FROM de-ruby-2.2.3

RUN cd /tmp \
&& wget https://rubygems.org/rubygems/rubygems-2.4.8.tgz \
&& tar -xzvf rubygems-2.4.8.tgz \
&& cd rubygems-2.4.8 \
&& ruby setup.rb \
&& gem install jekyll --pre

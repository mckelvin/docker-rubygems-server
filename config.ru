require 'rubygems'
require 'geminabox'

Geminabox.data = '/data/rubygems'
Geminabox.rubygems_proxy = true  # Allow pulling gems from another gem source.

run Geminabox::Server

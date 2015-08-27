require 'rubygems'
require 'geminabox'
require 'tilt/erb'

require_relative 'lib/auth/github'

Geminabox.data = '/srv/gems'
Geminabox.rubygems_proxy = true # Allow pulling gems from another gem source.
Geminabox.allow_remote_failure = true # Serve gems if upstream source is down.

run Geminabox::Server

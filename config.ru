require 'rubygems'
require 'geminabox'

Geminabox.data = '/srv/gems'
Geminabox.rubygems_proxy = true # Allow pulling gems from another gem source.
Geminabox.allow_remote_failure = true # Serve gems if upstream source is down.

run Geminabox::Server

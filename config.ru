require 'rubygems'
require 'geminabox'
require 'tilt/erb'

require_relative 'lib/auth'

Geminabox.data = ENV['RUBYGEMS_STORAGE'] if ENV['RUBYGEMS_STORAGE']
Geminabox.rubygems_proxy = true # Allow pulling gems from another gem source.
Geminabox.allow_remote_failure = true # Serve gems if upstream source is down.

use Rack::Auth::Basic do |_, token|
  Auth::Cache.authorized?(token) || Auth::GitHub.authorized?(token)
end if ENV['GITHUB_ORGANIZATION']

run Geminabox::Server

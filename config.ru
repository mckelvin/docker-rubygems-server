require 'rubygems'
require 'geminabox'
require 'tilt/erb'

require_relative 'lib/auth'

Geminabox.data = ENV.fetch 'RUBYGEMS_STORAGE', "#{__dir__}/data"
Geminabox.rubygems_proxy = true # Allow pulling gems from another gem source.
Geminabox.allow_remote_failure = true # Serve gems if upstream source is down.
Geminabox.ruby_gems_url = ENV.fetch 'RUBYGEMS_URL', "https://rubygems.org/"
Geminabox.bundler_ruby_gems_url = ENV.fetch 'BUNDLER_RUBYGEMS_URL', "https://bundler.rubygems.org/"

use Rack::Auth::Basic do |_, token|
  Auth::Cache.authorized?(token) || Auth::GitHub.authorized?(token)
end if ENV['GITHUB_ORGANIZATION']

run Geminabox::Server

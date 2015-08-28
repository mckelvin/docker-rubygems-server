require 'openssl'
require 'redis'
require 'securerandom'

module Auth
  # Caching methods for sessions.
  module Cache
    def self.redis_url
      @redis_host ||= ENV['REDIS_URL'] || ENV.fetch('REDIS_PORT', 'tcp://127.0.0.1:6379').sub('tcp://', 'redis://')
    end

    def self.redis
      @redis ||= Redis.new(url: redis_url)
    end

    def self.seed
      @seed ||= redis.get('rubygems:cache:seed') || SecureRandom.uuid.tap do |s|
        redis.set 'rubygems:cache:seed', s
      end
    end

    def self.session(token)
      @session ||= "rubygems:sessions:#{OpenSSL::HMAC.hexdigest OpenSSL::Digest::SHA256.new, seed, token}"
    end

    def self.add(token)
      redis.set session(token), true, ex: 300
    end

    def self.authorized?(token)
      redis.exists session token
    end
  end
end

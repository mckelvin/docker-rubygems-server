require 'redis'
require 'securerandom'

module Auth
  # Caching methods for sessions.
  module Cache
    def self.redis
      @redis ||= Redis.new
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

require 'octokit'

module Auth
  # Module for using GitHub authorization.
  module GitHub
    def self.github(access_token)
      Octokit::Client.new access_token: access_token
    end

    def self.user(access_token)
      github(access_token).user
    end

    def self.organizations(access_token)
      user(access_token).rels[:organizations].get.data
    end

    def self.in_organization?(access_token)
      organizations(access_token).any? do |organization|
        organization.login == ENV['GITHUB_ORGANIZATION']
      end
    end

    def self.authorized?(access_token)
      in_organization?(access_token)
    rescue Octokit::Unauthorized
      false
    end
  end
end

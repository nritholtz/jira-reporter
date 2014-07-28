module JiraReporter

  class Service

    include ActiveSupport::Configurable

    config_accessor :service_client

    def self.client
      config.service_client || raise("Please configure a service_client")
    end

  end

end
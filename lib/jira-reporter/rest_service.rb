module JiraReporter
  class RestService
    include HTTParty
    include ActiveSupport::Configurable

    API_VERSION = 2

    config_accessor :base_uri, :username, :password, :timeout_options
    format :json

    def self.get_open_tickets_by_project(project)
      resp = JiraReporter::Response.new(
        self.get(parse_query("/search?jql=fixVersion+>+latestReleasedVersion(#{project})and+project=\"#{project}\"+and+resolution=Unresolved"),
                 configure_options)
      ) do |response|
        return response["issues"].each_with_object([]){|issue, arr| arr << JiraReporter::Issue.new(issue)}
      end
    end

    def self.get_project_details(project)
      resp = JiraReporter::Response.new(
        self.get(parse_query("/project/#{project}"),
                 configure_options)
      ) do |response|
        return {key: response["key"], lead: response["lead"]["name"], url: "#{response['self'].split('rest')[0]}browse/#{response['key']}"}
      end
    end

    def self.configure_options(options={})
      raise "No configuration file found, please create a jira.yml in the config directory" unless File.exists?('config/jira.yml')
      @config =  YAML.load_file('config/jira.yml')
      options[:basic_auth] = {username:@config['username'], password:@config['password']}
      options[:base_uri] = @config['base_uri']+"rest/api/#{API_VERSION}"
      options[:timeout] = @config['timeout'] and @config['timeout'].to_i || 30
      options
    end

    private
    def self.parse_query(query)
     URI.encode(query)
    end
  end
end # end RestService class definition
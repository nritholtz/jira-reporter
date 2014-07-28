module JiraReporter 
  class Issue < JiraReporter::BaseObject

    def issuetype
      hash['fields']['issuetype']['name']
    end

    def fixVersion
      if hash['fields']['fixVersions']
        hash['fields']['fixVersions'][0]['name']
      else
        ""
      end
    end

    def reporter
      hash['fields']['reporter']['displayName']
    end

    def priority
      hash['fields']['priority']['name']
    end

    def status
      hash['fields']['status']['name']
    end

    def assignee
      hash['fields']['assignee']['name']
    end

    def project
      hash['fields']['project']['name']
    end

    def summary
      hash['fields']['summary']
    end

    def description
      hash['fields']['summary']
    end

    def affectsVersion
      if hash['fields']['versions']
        hash['fields']['versions'][0]['name']
      else
        ""
      end      
    end

    def url
      "#{hash['self'].split('rest')[0]}browse/#{key}"
    end
  end
end
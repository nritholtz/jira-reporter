module JiraReporter
  class Response

    attr_accessor :httparty_response, :payload

    def initialize(response)
      self.httparty_response = response
      if block_given? and success?
        self.payload = yield(response.parsed_response)
      elsif system_error?
        raise JiraReporter::Error.new(self)
      end
    end

    def success?
      self.httparty_response.code == 200
    end

    def validation_error?
      self.httparty_response.code == 422
    end

    def bad_request?
      self.httparty_response.code == 400
    end

    def parse_validation_errors
      if body.is_a?(Hash) and body["errors"].is_a?(Array)
        body["errors"].collect{|e|e["description"]}
      end
    end

    def system_error?
      !success? && !validation_error?
    end

    def not_found?
      response_code == 404
    end

    def body
      self.httparty_response.parsed_response
    end

    def response_message
      self.httparty_response.message
    end

    def response_code
      self.httparty_response.code
    end

    def parsed_response
      self.httparty_response.parsed_response
    end

    def request_url
      self.httparty_response.request.path.to_s
    end

    def error_messages
      body["errorMessages"]
    end

    def errors
      return [] if success?
      if validation_error?
        parse_validation_errors || ["Operation could not be completed"]
      elsif not_found?
        [response_message]
      elsif bad_request?
        error_messages.flatten.to_s
      else
        ["System Error"]
      end
    end
  end
end
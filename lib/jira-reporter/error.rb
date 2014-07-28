module JiraReporter
  class Error < StandardError

    attr_accessor :code, :response

    def initialize(response)
      self.code = response.response_code
      self.response = response
      super(response.response_message+" - "+response.errors)
    end
  end
end
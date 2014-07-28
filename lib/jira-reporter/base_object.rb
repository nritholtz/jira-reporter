# encoding: UTF-8
module JiraReporter
  class BaseObject

    attr_accessor :hash

    alias :attributes :hash

    def initialize(hash)
      self.hash = hash || {}
      after_initialize
    end

    def method_missing(name, *args)
      if self.hash and hash.key?(name.to_s.camelize(:lower))
        self.hash[name.to_s.camelize(:lower)]
      else
        super
      end
    end

    def respond_to?(name)
      if hash[name.to_s].present?
        true
      else
        super
      end
    end

    def after_initialize
    end
  end
end
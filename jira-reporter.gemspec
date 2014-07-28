# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'jira-reporter/version'

Gem::Specification.new do |s|
  s.name        = 'jira-reporter'
  s.version     =  JiraReporter::VERSION
  s.required_ruby_version = '>= 2.1.0'
  s.authors     =  ['Nathaniel Ritholtz']
  s.email       =  ['nritholtz@gmail.com']
  s.homepage    =  'https://github.com/nritholtz/jira-reporter'
  s.summary     =   %q{JIRA reporting tool}
  s.description =   %q{A JIRA analysis and reporting tool by using JIRA REST API}

  s.rubyforge_project = 'jira-reporter'

  s.files         =   `git ls-files`.split("\n")
  s.test_files    =   `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   =   `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f)}
  s.require_paths =  ['lib']

  s.add_runtime_dependency 'httparty', '~> 0.13.0'
  s.add_runtime_dependency 'activesupport', '~> 3.1'
  s.add_runtime_dependency 'activemodel', '~> 3.1'
  s.add_runtime_dependency 'actionpack', '~> 3.1'
end

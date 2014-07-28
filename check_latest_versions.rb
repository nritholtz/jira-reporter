require_relative 'lib/jira-reporter'

projects = YAML.load_file('jira.yml')['projects']

projects.each do |project|
  resp = JiraReporter::RestService.get_open_tickets_by_project(project)
  print "PROJECT: #{project} COUNT: #{resp[:count]}\n"
  if resp[:count] > 0
    resp[:issues].each_with_index do |issue, index|
      print "\t#{index+1})Ticket: #{issue.key} Summary: #{issue.summary} Assignee: #{issue.assignee}\n\tLink: #{issue.url} Status: #{issue.status} Fix Version: #{issue.fixVersion}\n"
    end
  end
end
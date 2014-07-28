jira-reporter
=======================

A reporting tool for JIRA projects

------------------------------------------
###Setup
Create a new file in the config folder jira.yml and insert your configuration mirroring the fields noted in the jira.yml.sample

###Get project information
`JiraReporter::RestService.get_project_details(project)`

###Get open issues in unreleased fixVersions
`JiraReporter::RestService.get_open_tickets_by_project(project)`

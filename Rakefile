# frozen_string_literal: true

# Managed by modulesync - DO NOT EDIT
# https://voxpupuli.org/docs/updating-files-managed-with-modulesync/

begin
  require 'rubygems'
  require 'github_changelog_generator/task'
rescue LoadError
  # github_changelog_generator isn't available, so we won't define a rake task with it
else
  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    config.header = "# Changelog\n\nAll notable changes to this project will be documented in this file."
    config.exclude_labels = %w[duplicate question invalid wontfix wont-fix skip-changelog modulesync github_actions]
    config.user = 'voxpupuli'
    config.project = 'container-puppetserver'
    # get branch name from git and strip off any prefixes (e.g. 'release-')
    config.future_release = `git rev-parse --abbrev-ref HEAD`.strip.split('-', 2).last
  end
end

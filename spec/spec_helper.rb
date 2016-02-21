if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  puts "Starting CodeClimate::TestReporter"
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'googledoc_markdown'

# Encoding: utf-8
require 'bundler/setup'

namespace :style do
  require 'rubocop/rake_task'
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  require 'foodcritic'
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

namespace :unit do
  # Rspec and ChefSpec
  desc 'Run ChefSpec examples'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
end

namespace :integration do
  desc 'Run integration tests with test-kitchen using vagrant'
  task :kitchen do
    require 'kitchen'
    # this enabled concurrent kitchen runs.
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.yml')
    config = Kitchen::Config.new(loader: @loader)
    threads = []
    config.instances.each do |instance|
      threads << Thread.new do
        instance.verify
      end
    end
    threads.map(&:join)
  end
end

namespace :smoke do
  desc 'Ensure the system load balancing round robin'
  # this task is really hacky, this is not a representation of my ruby skills.
  # its basically just to demonstrate that the nodes are being rr'd
  task :party do
    require 'httparty'
    results = []
    6.times do |_|
      # not catching exceptions or analysing the response, very bad.
      response_node = HTTParty.get('http://10.10.0.13').body.match(/node-\d/)[0]
      results << response_node
      puts "response from #{response_node}"
    end
    # this isnt an effective way to check if the nodes are actually being round robin load balanced.
    # but its terse and good enough.
    if results.uniq.length == 2
      puts 'nodes are being load balanced in a round robin manner'
    else
      puts 'epic fail'
    end
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# The default rake task should just run it all
task default: %w(style unit:spec integration:kitchen smoke:party)

unless ENV['CI']
  begin
    require 'kitchen/rake_tasks'
    Kitchen::RakeTasks.new
  rescue LoadError
    puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
  end
end

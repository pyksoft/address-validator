require 'jobs/print_job'

Resque.redis = ENV['REDISTOGO_URL']

Resque::Scheduler.dynamic = true

Resque.schedule = YAML.load_file(File.join(Rails.root, 'config', 'resque_schedule.yml'))

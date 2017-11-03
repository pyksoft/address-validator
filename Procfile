web: bundle exec passenger start -p $PORT --max-pool-size 3
worker: env TERM_CHILD=1 QUEUE=* bundle exec rake resque:work
scheduler: bundle exec rake resque:scheduler

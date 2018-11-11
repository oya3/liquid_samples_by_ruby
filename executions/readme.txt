$ bundle install --path vendor/bundle

# execution を取得する( product_id: 83, limit: 20, page: 1)
$ bundle exec ruby executions.rb

# execution for timestamp を取得する( product_id: 83, limit: 20, timestamp: unixtimestamp)
$ bundle exec ruby executions_for_timestamp.rb


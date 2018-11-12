#!/usr/bin/env fish

cd authentication
echo --- authentication ---
echo - authentication.rb
bundle exec ruby authentication.rb
cd ..

cd products
echo --- products ---
echo - products.rb
bundle exec ruby products.rb
echo - product.rb
bundle exec ruby product.rb
echo - orderbook.rb
bundle exec ruby orderbook.rb
cd ..

cd executions
echo --- executions ---
echo - executions.rb
bundle exec ruby executions.rb
echo - ecutions_for_timestamp.rb
bundle exec ruby executions_for_timestamp.rb
cd ..

cd interest_rates
echo --- interest_rates ---
echo - interest_rates.rb
bundle exec ruby interest_rates.rb
cd ..


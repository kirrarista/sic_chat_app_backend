rails new . --api --skip-kamal --skip-thruster --database=mysql
pwd
ls
exit
chown -R rails:rails /app
su - rails
exit
ls
exit
ls
# Stop all running containers
docker stop $(docker ps -aq)
# Remove all containers
docker rm $(docker ps -aq)
exit
chown -R rails:rails /app
exit
chown -R rails:rails /app
chmod -R u+rw /app
exit
bundle install
rails generate active_record:session_migration
rails db:migrate
exit
rails server -b 0.0.0.0 -p 3000
exit
exit
rails new . --name help_desk_backend --api --skip-kamal --skip-thruster  --database=mysql
gem install rails
rails new . --name help_desk_backend --api --skip-kamal --skip-thruster  --database=mysql
bundle install
rails db:create
rails server -b 0.0.0.0 -p 3000
rails generate active_record:session_migration
actionpack (8.1.1) lib/action_dispatch/middleware/se
rails db:migrate
rails server -b 0.0.0.0 -p 3000
ls
bin/rails test
bin/rails db:create RAILS_ENV=test
bin/rails db:migrate RAILS_ENV=test
bin/rails test
rails generate model BlogEntry title:string content:text author:string
rails db:migrate
rails generate controller BlogEntries index show new create edit update destroy
rails routes
rails console
rails server -b 0.0.0.0 -p 3000
rails test
rails test test/models/blog_entry_test.rb
rails test --verbose
rails db:seed
rails db:reset
rails db:seed
rails console
rails generate controller Health
rails console
rails db:schema:dump
sudo chown -R $USER:$USER .
rails server -b 0.0.0.0 -p 3000
cd ..
cd ..
rails server -b 0.0.0.0 -p 3000
pws
pwd
ls
cd ~
ls
rails server -b 0.0.0.0 -p 3000
rails server -b 0.0.0.0 -p 3000
bin/rails test
rails test
rails test test/controllers/health_controller_test.rb 
rails test test/controllers/health_controller_test.rb 
bin/rails routes | grep health
bin/rails test -v
bin/rails test -v
bin/rails test -v
bin/rails test TEST=test/controllers/health_controller_test.rb
bin/rails test test/controllers/health_controller_test.rb
bin/rails test test/controllers/health_controller_test.rb
bin/rails test/controllers/health_controller_test.rb
bin/rails test TEST=test/controllers/health_controller_test.rb
bin/rails test app/test/controllers/health_controller_test.rb
bin/rails test test/controllers/health_controller_test.rb
bin/rails db:test:prepare
bin/rails test test/controllers/health_controller_test.rb
bin/rails db:drop db:create db:migrate
bin/rails db:test:prepare
bin/rails test test/controllers/health_controller_test.rb
bin/rails db:test:prepare
exit

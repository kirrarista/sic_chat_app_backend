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
rails test
e
rails db:drop db:create db:migrate
RAILS_ENV=test rails db:drop db:create db:migrate
rails test
ls
ls db
ls db/migrate
ls app/models | grep blog
grep -R "blog" test/
grep -R "blog" app/
rm test/fixtures/blog_entries.yml
rails db:drop db:create db:migrate
RAILS_ENV=test rails db:drop db:create db:migrate
grep -R "blog_entries" .
ls db/migrate 
ls db/migrate | grep blog
rm db/migrate/*create_blog_entries*.rb
ls test/fixtures | grep blog
t
rm test/fixtures/blog_entries.yml
ls app/models | grep blog
rails db:drop db:create db:migrate
RAILS_ENV=test rails db:drop db:create db:migrate
rails tmp:clear
rails log:clear
rails test
rails server -b 0.0.0.0 -p 3000
rails generate model User username:string:unique password_digest:string last_active_at:datetime
rails generate model User username:string password_digest:string last_active_at:datetime
rails db:migrate
bundle install
rails test test/models/user_test.rb 
rails test test/models/user_test.rb 
rails test test/models/user_test.rb 
rails test
rails generate controller Users
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails console
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails dbconsole
.schema users
rails dbconsole
rails dbconsole
rails dbconsole
rails dbconsole
rails console
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test
rails test
rails test test/controllers/users_controller_test.rb 
rails server -b 0.0.0.0 -p 3000
rails server -b 0.0.0.0 -p 3000
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails server -b 0.0.0.0 -p 3000
rails test test/controllers/users_controller_test.rb 
rails server -b 0.0.0.0 -p 3000
rails test
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test
rails test
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/controllers/users_controller_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test test/requests/auth_test.rb 
rails test
rails generate model ExpertProfile user:references bio:text
rails db:migrate
rails db:migrate RAILS_ENV=test
rails test test/requests/auth_test.rb 
rails generate model Conversation title:string status:string initiator:references assigned_expert:references last_message_at:datetime
rails generate model Message conversation:references sender:references sender_role:string content:text is_read:boolean
rails generate model ExpertAssignment conversation:references expert:references status:string assigned_at:datetime resolved_at:datetime rating:integer
rails db:migrarte
rails db:migrate
rails db:migrate RAILS_ENV=test
rails generate controller Conversations
rails test test/requests/conversations_test.rb 
rails test test/requests/conversations_test.rb 
rails test test/requests/conversations_test.rb 
rails test test/requests/conversations_test.rb 
rails test test/requests/conversations_test.rb 
rails test
rails test
rails generate controller Messages --no-helper --no-assets --no-template-engine
rails test
rails test
rails test
rails generate controller Expert --no-helper --no-assets --no-template-engine
rails test
rails generate controller Api --no-helper --no-assets --no-template-engine
rails test
rails server -b 0.0.0.0 -p 3000
rails test
rails test
rails server -b 0.0.0.0 -p 3000
rails test
rails server -b 0.0.0.0 -p 3000
exit
sudo chown -R rails:rails .
chown -R rails:rails .
exit
rails server -b 0.0.0.0 -p 3000
exit
chown -R rails:rails .
exit
rails server -b 0.0.0.0 -p 3000
rails server -b 0.0.0.0 -p 3000
rails test
exit

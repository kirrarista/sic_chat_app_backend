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

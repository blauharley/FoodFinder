set :application, "FoodFinder"
set :repository,  "git@github.com:blauharley/FoodFinder.git"

set :deploy_to, "/var/www/virthosts/dinnercollective.multimediatechnology.at/"
set :port, 5412
set :user, "fhs33078"
set :use_sudo, false

set :scm, :git
set :branch, "master"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
default_environment["LANG"] = "en_US.UTF-8"

role :web, "multimediatechnology.at"                          # Your HTTP server, Apache/etc
role :app, "multimediatechnology.at"                          # This may be the same as your `Web` server
role :db,  "multimediatechnology.at", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   
   task :copy_config do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
 end
 
require "bundler/capistrano"

#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"

# load 'deploy/assets'

after "deploy:update_code", "deploy:copy_config"

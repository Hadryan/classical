set :application, "mimusicaclasica.com.ar"

set :scm, :git
set :repository, "git@gitosis.homelinux.com:classical.git"
set :branch, "master"
set :user, 'root'
set :keep_releases, 2

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_to, "/var/www/#{application}"

role :app, "74.207.229.192"
role :web, "74.207.229.192"
role :db,  "74.207.229.192", :primary => true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need

default_run_options[:pty] = true

task :after_update_code do
  sudo "chown -R www-data:www-data #{current_release}"
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end


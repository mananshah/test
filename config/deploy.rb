require "bundler/capistrano"
set :application, "testcapistrano"

set :rvm_ruby_string, "ruby-1.9.3-p194@testcapistrano" 
require "rvm/capistrano"
set :rvm_type, :user
set :rvm_install_ruby, :install

set :repository,  "git@github.com:mananshah/test.git"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "testcapistrano.manan.cs"                          # Your HTTP server, Apache/etc
role :app, "testcapistrano.manan.cs"                          # This may be the same as your `Web` server
role :db,  "testcapistrano.manan.cs", :primary => true # This is where Rails migrations will run

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/manan/capistron/"
set :deploy_via, :remote_cache
set :user, "nikhil"
set :password, "nikhil"
set :use_sudo, false
set :keep_releases, 5
before 'deploy:setup', 'rvm:install_ruby'

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
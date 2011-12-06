require "bundler/capistrano"

set :application, "failingsanta"
set :repository,  "git@github.com:rosscooperman/failingsanta.git"
set :deploy_to,   "/var/apps/#{application}"

set :scm,           :git
set :deploy_via,    :remote_cache
set :branch,        variables['branch'] || 'master'
set :keep_releases, 10

set :use_sudo,      false
set :user,          "deploy"

# silence an annoying warning on deployment
set :normalize_asset_timestamps, false

server "failingsanta.com", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after 'deploy:finalize_update' do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
end
after :deploy, "deploy:cleanup"

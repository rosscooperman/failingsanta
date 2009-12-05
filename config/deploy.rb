set :application, "failingsanta"
set :repository,  "git@github.fs:rosscooperman/failingsanta.git"
set :deploy_to,   "/var/www/apps/#{application}"

set :scm,           :git
set :deploy_via,    :remote_cache
set :branch,        variables['branch'] || 'master'
set :keep_releases, 10

set :use_sudo,      false
set :user,          "deploy"

server "www03.rosscooperman.com", :app, :web, :db, :primary => true

desc "Link in the production database.yml and run 'rake gems:refresh_specs'"
task :after_update_code do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
end

namespace :deploy do
    desc "Restarting passenger with restart.txt"
    task :restart, :roles => :app, :except => { :no_release => true } do
        run "touch #{current_path}/tmp/restart.txt"
    end

    [:start, :stop].each do |t|
        desc "#{t} task is a no-op with passenger"
        task t, :roles => :app do ; end
    end
end

after "deploy", "deploy:cleanup"

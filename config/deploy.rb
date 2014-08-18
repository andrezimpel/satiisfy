set :application, 'satiisfy'
set :repo_url, 'git@bitbucket.com:yum/satiisfy.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
# set :scm, :git

set :rvm_ruby_version, "1.9.3-p194@#{fetch(:application)}"
set :rvm_type, :user

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_dirs, [
  "public/system"
]

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'
end

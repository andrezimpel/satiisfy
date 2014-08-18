set :stage, :production
set :rails_env, :production
set :branch, 'master'

set :deploy_to, "/www/satiisfy"

set :stage, :production

server 'indigo.yum.de', roles: %w{web app db assets}, user: 'webmaster'

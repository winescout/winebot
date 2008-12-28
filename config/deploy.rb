set :application, "winebot"
set :repository,  "git@github.com:winescout/winebot.git"
set :scm, :git
set :scm_username, "winescout"
set :deploy_to, "/home/mattc/apps/winebot"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "192.168.0.3"
#role :web, "your web-server here"
role :db,  "192.168.0.3", :primary => true

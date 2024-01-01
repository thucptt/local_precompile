# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require "capistrano/rvm"
# require "capistrano/rbenv"
# require "capistrano/chruby"
# require "capistrano/bundler"
# require "capistrano/rails"
# require "capistrano/passenger"

require "capistrano/rbenv"
set :rbenv_type, :user
set :rbenv_ruby, "2.7.0"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all

require "capistrano/bundler"
# require "capistrano/rails/assets"
require "capistrano/rails/migrations"

# require "capistrano/puma"
# install_plugin Capistrano::Puma

# require "capistrano/yarn"
# set :yarn_flags, '--frozen-lockfile'

# require "capistrano/nvm"
# set :nvm_type, :user
# set :nvm_node, "v16.20.2"
# set :nvm_map_bins, %w[node npm yarn]

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

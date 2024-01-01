namespace :deploy do
  namespace :assets do
    desc 'Precompile assets locally'
    task :local_precompile do
      run_locally do
        execute "rm -rf #{fetch(:cache_dir)}"
        execute "RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:clean"
        execute "RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:precompile"
      end
    end

    desc 'rsync assets to web server'
    task :rsync_assets do
      on roles(:web), in: :parallel do |server|
        run_locally do
          ssh_shell   = %(-e "ssh -i #{fetch(:ssh_options)[:keys].first}")
          rsync_shell = "rsync -avz #{ssh_shell}"
          release_dir = "ubuntu@54.196.84.135:#{release_path}"
          commands    = []

          commands << "#{rsync_shell} ./#{fetch(:assets_dir)} #{release_dir}/#{fetch(:assets_dir)}" if Dir.exists?(fetch(:assets_dir))
          commands << "#{rsync_shell} ./#{fetch(:packs_dir)}  #{release_dir}/#{fetch(:packs_dir)}"  if Dir.exists?(fetch(:packs_dir))
          commands << "#{rsync_shell} ./#{fetch(:cache_dir)}  #{release_dir}/#{fetch(:cache_dir)}"  if Dir.exists?(fetch(:cache_dir))

          commands.each { |command| dry_run? ? SSHKit.config.output.info(command) : execute(command) }
        end
      end
    end
  end
end

namespace :load do
  task :defaults do
    set :assets_role, 'web'
    set :assets_dir,  'public/assets/'
    set :packs_dir,   'public/packs/'
    set :cache_dir,   'tmp/cache/'

    after 'deploy:migrate', 'deploy:assets:local_precompile'
    after 'deploy:assets:local_precompile', 'deploy:assets:rsync_assets'
  end
end

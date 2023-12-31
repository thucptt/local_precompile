namespace :puma do
  desc 'Restart puma'
  task :restart do
    on roles(:app) do
      within current_path do
        execute :bundle, :exec, :pumactl, '-P', fetch(:puma_pid), 'restart',
                '--config', fetch(:puma_config_path), 'RAILS_ENV=production'
      end
    end
  end

  desc 'Check and create puma.pid if it does not exists'
  task :check_create_pid do
    on roles(:app) do
      within current_path do
        unless test("[ -f #{shared_path}/tmp/pids/puma.pid ]")
          execute :mkdir, '-p', "#{shared_path}/tmp/pids"
          execute :touch, "#{shared_path}/tmp/pids/puma.pid"
        end
      end
    end
  end
end

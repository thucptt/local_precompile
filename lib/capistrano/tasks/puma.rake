namespace :puma do
  desc 'Start puma'
  task :start do
    on roles(:app) do
      within current_path do
        execute :bundle, 'exec', 'puma', '--config', "#{fetch(:puma_config_path)}", '--daemon'
      end
    end
  end

  desc 'Restart puma'
  task :restart do
    on roles(:app) do
      within current_path do
        if test("[ -f #{shared_path}/tmp/pids/server.pid ]")
          execute :bundle, :exec, :pumactl, '-P', fetch(:puma_pid), 'restart', '--config', fetch(:puma_config_path)
        else
          invoke 'puma:start'
        end
      end
    end
  end

  desc 'Stop puma'
  task :stop do
    on roles(:app) do
      within current_path do
        execute :bundle, :exec, 'pumactl', '-P', fetch(:puma_pid), 'stop'
      end
    end
  end
end

namespace :load do
  task :defaults do
    after "deploy:publishing", "puma:restart"
  end
end

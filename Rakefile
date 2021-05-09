require File.expand_path('../application.rb', __FILE__)
namespace :covid do
  task :ping_empty_slots do
    # MyInitializers.initialize_config
    Application.new.send_notification
  end
end

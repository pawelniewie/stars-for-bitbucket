if Rails.application.config.active_job.queue_adapter == :shoryuken
  # Every environment has different queue name eg. `development_work_queue`
  Shoryuken.active_job_queue_name_prefixing = true

  # Load configuration from config/shoryuken.yml file.
  Shoryuken::EnvironmentLoader.load_for_rails_console
end

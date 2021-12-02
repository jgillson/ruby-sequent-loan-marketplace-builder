require_relative "../../db/sequent_migrations"

Sequent.configure do |config|
  config.migrations_class_name = "SequentMigrations"

  config.command_handlers = []

  config.event_handlers = []

  config.database_config_directory = "config"
  config.migration_sql_files_directory = "db/sequent"
end

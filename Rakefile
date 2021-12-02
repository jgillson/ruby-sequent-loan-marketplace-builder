# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
ENV["RACK_ENV"] = ENV["RAILS_ENV"] ||= "development"

require_relative "config/application"

Rails.application.load_tasks

require "sequent/rake/migration_tasks"

require_relative "config/initializers/sequent"

Sequent::Rake::MigrationTasks.new.register_tasks!

task "sequent:migrate:init" => [:sequent_db_connect]

task "sequent_db_connect" do
  Sequent::Support::Database.connect!(ENV["RACK_ENV"])
end

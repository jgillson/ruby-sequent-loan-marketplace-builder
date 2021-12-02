require_relative "../../db/sequent_migrations"
require_relative "../../app/sequent/lib/borrower"
require_relative "../../app/sequent/lib/investor"
require_relative "../../app/sequent/lib/investor_group"
require_relative "../../app/sequent/lib/loan"
require_relative "../../app/sequent/lib/marketplace"

Sequent.configure do |config|
  config.migrations_class_name = "SequentMigrations"

  config.command_handlers = [
    InvestorGroupCommandHandler,
    InvestorCommandHandler,
    BorrowerCommandHandler,
    MarketplaceCommandHandler,
    LoanCommandHandler
  ]

  config.event_handlers = [
    InvestorGroupProjector,
    InvestorProjector,
    BorrowerProjector,
    MarketplaceProjector,
    LoanProjector
  ]

  config.database_config_directory = "config"
  config.migration_sql_files_directory = "db/sequent"
end

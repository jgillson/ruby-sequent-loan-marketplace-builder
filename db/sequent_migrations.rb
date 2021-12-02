require_relative "../app/sequent/projectors/loan_projector"
require_relative "../app/sequent/projectors/marketplace_projector"
require_relative "../app/sequent/projectors/investor_projector"
require_relative "../app/sequent/projectors/borrower_projector"
require_relative "../app/sequent/projectors/investor_group_projector"

VIEW_SCHEMA_VERSION = 1

class SequentMigrations < Sequent::Migrations::Projectors
  def self.version
    VIEW_SCHEMA_VERSION
  end

  def self.versions
    {
      "1" => [
        LoanProjector,
        MarketplaceProjector,
        InvestorProjector,
        BorrowerProjector,
        InvestorGroupProjector
      ]
    }
  end
end

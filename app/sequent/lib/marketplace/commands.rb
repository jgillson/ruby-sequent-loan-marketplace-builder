# Marketplace commands
# Commands form the API of your domain
class CreateMarketplace < Sequent::Command
  attrs loan_aggregate_id: String, name: String
  validates_presence_of :loan_aggregate_id, :name
end

class EditMarketplace < Sequent::Command
  attrs name: String
end

class DeleteMarketplace < Sequent::Command
  attrs aggregate_id: String
end

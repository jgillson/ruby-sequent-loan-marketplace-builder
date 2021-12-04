# InvestorGroup commands
# Commands form the API of your domain
class AddInvestorGroup < Sequent::Command
  attrs marketplace_aggregate_id: String, name: String, description: String
  validates_presence_of :marketplace_aggregate_id, :name, :description
end

class EditInvestorGroup < Sequent::Command
  attrs name: String, description: String
end

class DeleteInvestorGroup < Sequent::Command
  attrs aggregate_id: String
end

class AddInvestorToInvestorGroup < Sequent::Command
  attrs aggregate_id: String, investor_aggregate_id: String
  validates_presence_of :aggregate_id, :investor_aggregate_id
end

class RemoveInvestorFromInvestorGroup < Sequent::Command
  attrs aggregate_id: String, investor_aggregate_id: String
  validates_presence_of :aggregate_id, :investor_aggregate_id
end

# Investor commands
# Commands form the API of your domain
class CreateInvestor < Sequent::Command
  attrs name: String, description: String, funding_amount: Float
  validates_presence_of :name, :description, :funding_amount
end

class EditInvestor < Sequent::Command
  attrs name: String, description: String, funding_amount: Float
end

class DeleteInvestor < Sequent::Command
  attrs aggregate_id: String
end

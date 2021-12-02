# Loan commands
# Commands form the API of your domain
class CreateLoan < Sequent::Command
  attrs borrower_aggregate_id: String, investor_aggregate_id: String, name: String, amount: Float
  validates_presence_of :borrower_aggregate_id, :investor_aggregate_id, :name, :amount
end

class EditLoan < Sequent::Command
  attrs name: String, amount: Float
end

class DeleteLoan < Sequent::Command
  attrs aggregate_id: String
end

# Borrower commands
# Commands form the API of your domain
class CreateBorrower < Sequent::Command
  attrs name: String, description: String, requested_amount: Float
  validates_presence_of :name, :description, :requested_amount
end

class EditBorrower < Sequent::Command
  attrs name: String, description: String, requested_amount: Float
end

class DeleteBorrower < Sequent::Command
  attrs aggregate_id: String
end

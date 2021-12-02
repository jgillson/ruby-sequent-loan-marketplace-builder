# Events for Loan
# An Event describes something that happened
# By subclassing from Sequent::Event you get 2 extra attributes:
# -> aggregate_id and sequence_number; both form the unique key of an Event
class LoanCreated < Sequent::Event
  attrs borrower_aggregate_id: String, investor_aggregate_id: String
end

class LoanNameUpdated < Sequent::Event
  attrs name: String
end

class LoanAmountUpdated < Sequent::Event
  attrs amount: Float
end

class LoanDeleted < Sequent::Event
  attrs aggregate_id: String
end

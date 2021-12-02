# Events for Borrower
# An Event describes something that happened
# By subclassing from Sequent::Event, you get 2 extra attributes:
# -> aggregate_id and sequence_number; both form the unique key of an Event
class BorrowerCreated < Sequent::Event
end

class BorrowerNameUpdated < Sequent::Event
  attrs name: String
end

class BorrowerDescriptionUpdated < Sequent::Event
  attrs description: String
end

class BorrowerRequestedAmountUpdated < Sequent::Event
  attrs requested_amount: Float
end

class BorrowerDeleted < Sequent::Event
  attrs aggregate_id: String
end

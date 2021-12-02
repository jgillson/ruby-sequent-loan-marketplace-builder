# Events for Investor
# An Event describes something that happened
# By subclassing from Sequent::Event, you get 2 extra attributes:
# -> aggregate_id and sequence_number; both form the unique key of an Event
class InvestorCreated < Sequent::Event
end

class InvestorNameUpdated < Sequent::Event
  attrs name: String
end

class InvestorDescriptionUpdated < Sequent::Event
  attrs description: String
end

class InvestorFundingAmountUpdated < Sequent::Event
  attrs funding_amount: Float
end

class InvestorDeleted < Sequent::Event
  attrs aggregate_id: String
end

# Events for InvestorGroup
# An Event describes something that happened
# By subclassing from Sequent::Event, you get 2 extra attributes:
# -> aggregate_id and sequence_number; both form the unique key of an Event
class InvestorGroupCreated < Sequent::Event
  attrs marketplace_aggregate_id: String
end

class InvestorGroupNameUpdated < Sequent::Event
  attrs name: String
end

class InvestorGroupDescriptionUpdated < Sequent::Event
  attrs description: String
end

class InvestorGroupDeleted < Sequent::Event
  attrs aggregate_id: String
end

class InvestorAddedToInvestorGroup < Sequent::Event
  attrs aggregate_id: String, investor_aggregate_id: String
end

class InvestorRemovedFromInvestorGroup < Sequent::Event
  attrs aggregate_id: String, investor_aggregate_id: String
end

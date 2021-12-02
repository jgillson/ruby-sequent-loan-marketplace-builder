# Events for Marketplace
# An Event describes something that happened
# By subclassing from Sequent::Event you get 2 extra attributes:
# -> aggregate_id and sequence_number; both form the unique key of an Event
class MarketplaceCreated < Sequent::Event
  attrs loan_aggregate_id: String
end

class MarketplaceNameUpdated < Sequent::Event
  attrs name: String
end

class MarketplaceDeleted < Sequent::Event
  attrs aggregate_id: String
end

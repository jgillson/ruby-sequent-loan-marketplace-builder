# The MarketplaceAggregate AggregateRoot
# An AggregateRoot is the class that encapsulates domain or business logic
# Aggregates form the heart of an application
# All Events of a particular AggregateRoot are called an EventStream
class MarketplaceAggregate < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply MarketplaceCreated, loan_aggregate_id: command.loan_aggregate_id
    apply MarketplaceNameUpdated, name: command.name
  end

  def edit(name)
    apply MarketplaceNameUpdated, name: name
  end

  def delete
    apply MarketplaceDeleted
  end

  on MarketplaceDeleted do
    @deleted = true
  end
end

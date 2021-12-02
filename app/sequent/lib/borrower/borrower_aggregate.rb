# The Borrower AggregateRoot
# An AggregateRoot is the class that encapsulates domain or business logic
# Aggregates form the heart of an application
# All Events of a particular AggregateRoot are called an EventStream
class BorrowerAggregate < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply BorrowerCreated
    apply BorrowerNameUpdated, name: command.name
    apply BorrowerDescriptionUpdated, description: command.description
    apply BorrowerRequestedAmountUpdated, requested_amount: command.requested_amount
  end

  def edit(name, description, requested_amount)
    apply BorrowerNameUpdated, name: name
    apply BorrowerDescriptionUpdated, description: description
    apply BorrowerRequestedAmountUpdated, requested_amount: requested_amount
  end

  def delete
    apply BorrowerDeleted
  end

  on BorrowerCreated do
  end

  on BorrowerDeleted do
    @deleted = true
  end

  on BorrowerNameUpdated do |event|
    @name = event.name
  end

  on BorrowerDescriptionUpdated do |event|
    @description = event.description
  end

  on BorrowerRequestedAmountUpdated do |event|
    @requested_amount = event.requested_amount
  end
end

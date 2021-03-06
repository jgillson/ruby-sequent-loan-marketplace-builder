# The InvestorGroup AggregateRoot
# An AggregateRoot is the class that encapsulates domain or business logic
# Aggregates form the heart of an application
# All Events of a particular AggregateRoot are called an EventStream
class InvestorGroupAggregate < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply InvestorGroupCreated, marketplace_aggregate_id: command.marketplace_aggregate_id
    apply InvestorGroupNameUpdated, name: command.name
    apply InvestorGroupDescriptionUpdated, description: command.description
  end

  def add_investor(investor_aggregate_id)
    apply InvestorAddedToInvestorGroup, investor_aggregate_id: investor_aggregate_id
  end

  def remove_investor(investor_aggregate_id)
    apply InvestorRemovedFromInvestorGroup, investor_aggregate_id: investor_aggregate_id
  end

  def edit(name, description)
    apply InvestorGroupNameUpdated, name: name
    apply InvestorGroupDescriptionUpdated, description: description
  end

  def delete
    apply InvestorGroupDeleted
  end

  on InvestorGroupCreated do
  end

  on InvestorGroupDeleted do
    @deleted = true
  end

  on InvestorGroupNameUpdated do |event|
    @name = event.name
  end

  on InvestorGroupDescriptionUpdated do |event|
    @description = event.description
  end
end

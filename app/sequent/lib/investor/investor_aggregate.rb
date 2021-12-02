# The Investor AggregateRoot
# An AggregateRoot is the class that encapsulates domain or business logic
# Aggregates form the heart of an application
# All Events of a particular AggregateRoot are called an EventStream
class InvestorAggregate < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply InvestorCreated
    apply InvestorNameUpdated, name: command.name
    apply InvestorDescriptionUpdated, description: command.description
    apply InvestorFundingAmountUpdated, funding_amount: command.funding_amount
  end

  def edit(name, description, funding_amount)
    apply InvestorNameUpdated, name: name
    apply InvestorDescriptionUpdated, description: description
    apply InvestorFundingAmountUpdated, funding_amount: funding_amount
  end

  def delete
    apply InvestorDeleted
  end

  on InvestorCreated do
  end

  on InvestorDeleted do
    @deleted = true
  end

  on InvestorNameUpdated do |event|
    @name = event.name
  end

  on InvestorDescriptionUpdated do |event|
    @description = event.description
  end

  on InvestorFundingAmountUpdated do |event|
    @funding_amount = event.funding_amount
  end
end

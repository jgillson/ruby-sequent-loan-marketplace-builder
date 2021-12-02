# The LoanAggregate AggregateRoot
# An AggregateRoot is the class that encapsulates domain or business logic
# Aggregates form the heart of an application
# All Events of a particular AggregateRoot are called an EventStream
class LoanAggregate < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply LoanCreated, borrower_aggregate_id: command.borrower_aggregate_id, investor_aggregate_id: command.investor_aggregate_id
    apply LoanNameUpdated, name: command.name
    apply LoanAmountUpdated, amount: command.amount
  end

  def edit(name, amount)
    apply LoanNameUpdated, name: name
    apply LoanAmountUpdated, amount: amount
  end

  def delete
    apply LoanDeleted
  end

  on LoanDeleted do
    @deleted = true
  end
end

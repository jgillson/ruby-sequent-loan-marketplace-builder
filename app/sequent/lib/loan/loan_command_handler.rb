# Subscribes to Loan commands and dispatches Job events
# The Sequent::BorrowerCommandHandler exposes two convenience methods:
# -> repository, a shorthand for Sequent.configuration.aggregate_repository
# -> do_with_aggregate, basically a shorthand for repository.load_aggregate
class LoanCommandHandler < Sequent::CommandHandler
  on CreateLoan do |command|
    repository.add_aggregate LoanAggregate.new(command)
  end

  on EditLoan do |command|
    do_with_aggregate(command, LoanAggregate) do |loan|
      loan.edit(command.name, command.amount)
    end
  end

  on DeleteLoan do |command|
    do_with_aggregate(command, LoanAggregate) do |loan|
      loan.delete
    end
  end
end

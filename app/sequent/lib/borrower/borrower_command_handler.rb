# Subscribes to Borrower commands and dispatches Borrower events
# The Sequent::BorrowerCommandHandler exposes two convenience methods:
# -> repository, a shorthand for Sequent.configuration.aggregate_repository
# -> do_with_aggregate, a shorthand for repository.load_aggregate
class BorrowerCommandHandler < Sequent::CommandHandler
  on CreateBorrower do |command|
    repository.add_aggregate BorrowerAggregate.new(command)
  end

  on EditBorrower do |command|
    do_with_aggregate(command, BorrowerAggregate) do |borrower|
      borrower.edit(command.name, command.description, command.requested_amount)
    end
  end

  on DeleteBorrower do |command|
    do_with_aggregate(command, BorrowerAggregate) do |borrower|
      borrower.delete
    end
  end
end

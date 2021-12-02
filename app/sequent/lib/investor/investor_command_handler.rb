# Subscribes to Investor commands and dispatches Investor events
# The Sequent::BorrowerCommandHandler exposes two convenience methods:
# -> repository, a shorthand for Sequent.configuration.aggregate_repository
# -> do_with_aggregate, a shorthand for repository.load_aggregate
class InvestorCommandHandler < Sequent::CommandHandler
  on CreateInvestor do |command|
    repository.add_aggregate InvestorAggregate.new(command)
  end

  on EditInvestor do |command|
    do_with_aggregate(command, InvestorAggregate) do |investor|
      investor.edit(command.name, command.description, command.funding_amount)
    end
  end

  on DeleteInvestor do |command|
    do_with_aggregate(command, InvestorAggregate) do |investor|
      investor.delete
    end
  end
end

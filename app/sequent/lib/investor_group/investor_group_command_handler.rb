# Subscribes to Investor commands and dispatches Investor events
# The Sequent::BorrowerCommandHandler exposes two convenience methods:
# -> repository, a shorthand for Sequent.configuration.aggregate_repository
# -> do_with_aggregate, a shorthand for repository.load_aggregate
class InvestorGroupCommandHandler < Sequent::CommandHandler
  on AddInvestorGroup do |command|
    repository.add_aggregate InvestorGroupAggregate.new(command)
  end

  on DeleteInvestorGroup do |command|
    do_with_aggregate(command, InvestorGroupAggregate) do |investor_group|
      investor_group.delete
    end
  end

  on AddInvestorToInvestorGroup do |command|
    do_with_aggregate(command, InvestorGroupAggregate) do |investor_group|
      investor_group.add_investor(command.investor_aggregate_id)
    end
  end

  on RemoveInvestorFromInvestorGroup do |command|
    do_with_aggregate(command, InvestorGroupAggregate) do |investor_group|
      investor_group.remove_investor(command.investor_aggregate_id)
    end
  end
end

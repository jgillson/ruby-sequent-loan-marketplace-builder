# Subscribes to Marketplace commands and dispatches Marketplace events
# The Sequent::BorrowerCommandHandler exposes two convenience methods:
# -> repository, a shorthand for Sequent.configuration.aggregate_repository
# -> do_with_aggregate, basically a shorthand for repository.load_aggregate
class MarketplaceCommandHandler < Sequent::CommandHandler
  on CreateMarketplace do |command|
    repository.add_aggregate MarketplaceAggregate.new(command)
  end

  on EditMarketplace do |command|
    do_with_aggregate(command, MarketplaceAggregate) do |marketplace|
      marketplace.edit(command.name)
    end
  end

  on DeleteMarketplace do |command|
    do_with_aggregate(command, MarketplaceAggregate) do |marketplace|
      marketplace.delete
    end
  end
end

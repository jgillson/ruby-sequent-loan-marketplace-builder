require_relative "../records/marketplace"
require_relative "../lib/marketplace/events"

# The MarketplaceProjector is responsible for creating projections based on events.
# Projections are records in tables
# To store something in a Projection you need 3 things:
# 1. A Projector - creates Projections
# 2. A Record class - updated/created/deleted inside Projections and regarded as read-only
# 3. A SQL file - contains the table definition in which the Record will be stored
class MarketplaceProjector < Sequent::Projector
  manages_tables Marketplace

  on MarketplaceCreated do |event|
    create_record(
      Marketplace,
      aggregate_id: event.aggregate_id,
      loan_aggregate_id: event.loan_aggregate_id
    )
  end

  on MarketplaceDeleted do |event|
    Marketplace.find_by(event.attributes.slice(:aggregate_id)).destroy
  end

  on MarketplaceNameUpdated do |event|
    update_all_records(
      Marketplace,
      {aggregate_id: event.aggregate_id}, event.attributes.slice(:name)
    )
  end
end

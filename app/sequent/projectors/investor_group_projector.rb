require_relative "../records/investor_group"
require_relative "../records/investor_investor_group"
require_relative "../lib/investor_group/events"

# The InvestorGroupProjector is responsible for creating projections based on events.
# Projections are records in tables
# To store something in a Projection you need 3 things:
# 1. A Projector - creates Projections
# 2. A Record class - updated/created/deleted inside Projections and regarded as read-only
# 3. A SQL file - contains the table definition in which the Record will be stored
class InvestorGroupProjector < Sequent::Projector
  manages_tables(InvestorGroup, InvestorInvestorGroup)

  on InvestorGroupCreated do |event|
    create_record(
      InvestorGroup,
      aggregate_id: event.aggregate_id,
      marketplace_aggregate_id: event.marketplace_aggregate_id
    )
  end

  on InvestorGroupDeleted do |event|
    InvestorGroup.find_by(event.attributes.slice(:aggregate_id)).destroy
  end

  on InvestorGroupNameUpdated do |event|
    update_all_records(
      InvestorGroup,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:name)
    )
  end

  on InvestorGroupDescriptionUpdated do |event|
    update_all_records(
      InvestorGroup,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:description)
    )
  end

  on InvestorAddedToInvestorGroup do |event|
    investor_group = InvestorGroup.find_by(event.attributes.slice(:aggregate_id))
    investor = Investor.find_by(aggregate_id: event.investor_aggregate_id)
    investor_group.investors << investor
  end

  on InvestorRemovedFromInvestorGroup do |event|
    investor_group = InvestorGroup.find_by(event.attributes.slice(:aggregate_id))
    investor = Investor.find_by(aggregate_id: event.investor_aggregate_id)
    investor_group.investors.destroy(investor.aggregate_id)
  end
end

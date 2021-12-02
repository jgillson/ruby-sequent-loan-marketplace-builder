require_relative "../records/investor"
require_relative "../lib/investor/events"

# The InvestorProjector is responsible for creating projections based on events.
# Projections are records in tables
# To store something in a Projection you need 3 things:
# 1. A Projector - creates Projections
# 2. A Record class - updated/created/deleted inside Projections and regarded as read-only
# 3. A SQL file - contains the table definition in which the Record will be stored
class InvestorProjector < Sequent::Projector
  manages_tables Investor

  on InvestorCreated do |event|
    create_record(
      Investor,
      aggregate_id: event.aggregate_id
    )
  end

  on InvestorDeleted do |event|
    Investor.find_by(event.attributes.slice(:aggregate_id)).destroy
  end

  on InvestorNameUpdated do |event|
    update_all_records(
      Investor,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:name)
    )
  end

  on InvestorDescriptionUpdated do |event|
    update_all_records(
      Investor,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:description)
    )
  end

  on InvestorFundingAmountUpdated do |event|
    update_all_records(
      Investor,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:funding_amount)
    )
  end
end

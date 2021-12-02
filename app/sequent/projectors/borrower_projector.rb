require_relative "../records/borrower"
require_relative "../lib/borrower/events"

# The BorrowerProjector is responsible for creating projections based on events.
# Projections are records in tables
# To store something in a Projection you need 3 things:
# 1. A Projector - creates Projections
# 2. A Record class - updated/created/deleted inside Projections and regarded as read-only
# 3. A SQL file - contains the table definition in which the Record will be stored
class BorrowerProjector < Sequent::Projector
  manages_tables Borrower

  on BorrowerCreated do |event|
    create_record(
      Borrower,
      aggregate_id: event.aggregate_id
    )
  end

  on BorrowerDeleted do |event|
    Borrower.find_by(event.attributes.slice(:aggregate_id)).destroy
  end

  on BorrowerNameUpdated do |event|
    update_all_records(
      Borrower,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:name)
    )
  end

  on BorrowerDescriptionUpdated do |event|
    update_all_records(
      Borrower,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:description)
    )
  end

  on BorrowerRequestedAmountUpdated do |event|
    update_all_records(
      Borrower,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:requested_amount)
    )
  end
end

require_relative "../records/loan"
require_relative "../lib/loan/events"

# The LoanProjector is responsible for creating projections based on events.
# Projections are records in tables
# To store something in a Projection you need 3 things:
# 1. A Projector - creates Projections
# 2. A Record class - updated/created/deleted inside Projections and regarded as read-only
# 3. A SQL file - contains the table definition in which the Record will be stored
class LoanProjector < Sequent::Projector
  manages_tables Loan

  on LoanCreated do |event|
    create_record(
      Loan,
      aggregate_id: event.aggregate_id,
      borrower_aggregate_id: event.borrower_aggregate_id,
      investor_aggregate_id: event.investor_aggregate_id
    )
  end

  on LoanDeleted do |event|
    Loan.find_by(event.attributes.slice(:aggregate_id)).destroy
  end

  on LoanNameUpdated do |event|
    update_all_records(
      Loan,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:name)
    )
  end

  on LoanAmountUpdated do |event|
    update_all_records(
      Loan,
      {aggregate_id: event.aggregate_id},
      event.attributes.slice(:amount)
    )
  end
end

require_relative "../../../../spec_helper"

describe BorrowerCommandHandler do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:name) { "ABC Investor"  }
  let(:description) { "An Investor" }
  let(:requested_amount) { 1_00_000.00 }

  before :each do
    Sequent.configuration.command_handlers = [BorrowerCommandHandler.new]
  end

  context CreateBorrower do
    it "creates a borrower" do
      when_command CreateBorrower.new(aggregate_id: aggregate_id, name: name, description: description, requested_amount: requested_amount)
      then_events BorrowerCreated.new(aggregate_id: aggregate_id, sequence_number: 1),
                  BorrowerNameUpdated,
                  BorrowerDescriptionUpdated,
                  BorrowerRequestedAmountUpdated
    end
  end

  context EditBorrower do
    before { when_command CreateBorrower.new(aggregate_id: aggregate_id, name: name, description: description, requested_amount: requested_amount) }

    it "edits a borrower" do
      when_command EditBorrower.new(aggregate_id: aggregate_id, name: "Updated Name", description: "Updated Description", requested_amount: 2_000_000.00)
      then_events BorrowerCreated.new(aggregate_id: aggregate_id, sequence_number: 1),
                  BorrowerNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  BorrowerDescriptionUpdated.new(aggregate_id: aggregate_id, description: description, sequence_number: 2),
                  BorrowerRequestedAmountUpdated.new(aggregate_id: aggregate_id, requested_amount: requested_amount, sequence_number: 2),
                  BorrowerNameUpdated.new(aggregate_id: aggregate_id, name: "Updated Name", sequence_number: 1),
                  BorrowerDescriptionUpdated.new(aggregate_id: aggregate_id, description: "Updated Description", sequence_number: 1),
                  BorrowerRequestedAmountUpdated.new(aggregate_id: aggregate_id, requested_amount:2_000_000.00, sequence_number: 1)

    end
  end

  context DeleteBorrower do
    before { when_command CreateBorrower.new(aggregate_id: aggregate_id, name: name, description: description, requested_amount: requested_amount) }

    it "deletes a borrower" do
      when_command DeleteBorrower.new(aggregate_id: aggregate_id)
      then_events BorrowerCreated.new(aggregate_id: aggregate_id, sequence_number: 1),
                  BorrowerNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  BorrowerDescriptionUpdated.new(aggregate_id: aggregate_id, description: description, sequence_number: 1),
                  BorrowerRequestedAmountUpdated.new(aggregate_id: aggregate_id, requested_amount: requested_amount, sequence_number: 1),
                  BorrowerDeleted.new(aggregate_id: aggregate_id, sequence_number: 1)
    end
  end
end


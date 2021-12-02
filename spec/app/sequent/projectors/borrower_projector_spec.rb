require_relative "../../../spec_helper"

describe BorrowerProjector do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:borrower_projector) { BorrowerProjector.new }
  let(:borrower_created) { BorrowerCreated.new(aggregate_id: aggregate_id, sequence_number: 1) }
  let(:borrower_deleted) { BorrowerDeleted.new(aggregate_id: aggregate_id, sequence_number: 1) }

  context BorrowerCreated do
    it "creates a projection" do
      borrower_projector.handle_message(borrower_created)
      expect(Borrower.count).to eq(1)
      record = Borrower.first
      expect(record.aggregate_id).to eq(aggregate_id)
    end
  end

  context BorrowerDeleted do
    before { borrower_projector.handle_message(borrower_created) }

    it "updates a projection" do
      expect(Borrower.count).to eq(1)
      record = Borrower.first
      expect(record.aggregate_id).to eq(aggregate_id)

      borrower_projector.handle_message(borrower_deleted)
      expect(Borrower.count).to eq(0)
    end
  end

  context BorrowerNameUpdated do
    let(:borrower_name_updated) do
      BorrowerNameUpdated.new(aggregate_id: aggregate_id, name: "Test Name", sequence_number: 2)
    end

    before { borrower_projector.handle_message(borrower_created) }

    it "updates a projection" do
      borrower_projector.handle_message(borrower_name_updated)
      expect(Borrower.count).to eq(1)
      record = Borrower.first
      expect(record.name).to eq("Test Name")
    end
  end

  context BorrowerDescriptionUpdated do
    let(:borrower_description_updated) do
      BorrowerDescriptionUpdated.new(aggregate_id: aggregate_id, description: "Test Description", sequence_number: 2)
    end

    before { borrower_projector.handle_message(borrower_created) }

    it "updates a projection" do
      borrower_projector.handle_message(borrower_description_updated)
      expect(Borrower.count).to eq(1)
      record = Borrower.first
      expect(record.description).to eq("Test Description")
    end
  end

  context BorrowerRequestedAmountUpdated do
    let(:borrower_requested_amount_updated) do
      BorrowerRequestedAmountUpdated.new(aggregate_id: aggregate_id, requested_amount: 20_000_000.00, sequence_number: 2)
    end

    before { borrower_projector.handle_message(borrower_created) }

    it "updates a projection" do
      borrower_projector.handle_message(borrower_requested_amount_updated)
      expect(Borrower.count).to eq(1)
      record = Borrower.first
      expect(record.requested_amount).to eq(20_000_000.00)
    end
  end
end

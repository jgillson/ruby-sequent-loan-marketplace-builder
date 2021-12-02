require_relative "../../../spec_helper"

describe MarketplaceProjector do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:borrower_aggregate_id) { Sequent.new_uuid }
  let(:investor_aggregate_id) { Sequent.new_uuid }
  let(:marketplace_aggregate_id) { Sequent.new_uuid }
  let(:loan_aggregate_id) { Sequent.new_uuid }
  let(:marketplace_projector) { MarketplaceProjector.new }
  let(:marketplace_created) { MarketplaceCreated.new(aggregate_id: aggregate_id, loan_aggregate_id: loan_aggregate_id, sequence_number: 1) }

  before :each do
    LoanProjector.new.handle_message(LoanCreated.new(aggregate_id: loan_aggregate_id, borrower_aggregate_id: borrower_aggregate_id,
                                                     investor_aggregate_id: investor_aggregate_id, sequence_number: 1))
  end

  context MarketplaceCreated do
    it "creates a projection" do
      marketplace_projector.handle_message(marketplace_created)
      expect(Marketplace.count).to eq(1)
      record = Marketplace.first
      expect(record.aggregate_id).to eq(aggregate_id)
      expect(record.loan_aggregate_id).to eq(loan_aggregate_id)
    end
  end

  context MarketplaceNameUpdated do
    let(:marketplace_name_updated) do
      MarketplaceNameUpdated.new(aggregate_id: aggregate_id, name: "Test Marketplace Name", sequence_number: 2)
    end

    before { marketplace_projector.handle_message(marketplace_created) }

    it "updates a projection" do
      marketplace_projector.handle_message(marketplace_name_updated)
      expect(Marketplace.count).to eq(1)
      record = Marketplace.first
      expect(record.name).to eq("Test Marketplace Name")
    end
  end
end

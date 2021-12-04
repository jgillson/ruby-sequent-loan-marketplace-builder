require_relative "../../../spec_helper"

describe InvestorGroupProjector do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:marketplace_aggregate_id) { Sequent.new_uuid }
  let(:loan_aggregate_id) { Sequent.new_uuid }
  let(:investor_aggregate_id) { Sequent.new_uuid }
  let(:borrower_aggregate_id) { Sequent.new_uuid }
  let(:investor_projector) { InvestorProjector.new }
  let(:borrower_projector) { BorrowerProjector.new }
  let(:investor_group_projector) { InvestorGroupProjector.new }
  let(:investor_created) { InvestorCreated.new(aggregate_id: investor_aggregate_id, sequence_number: 1) }
  let(:borrower_created) { BorrowerCreated.new(aggregate_id: borrower_aggregate_id, sequence_number: 1) }
  let(:investor_group_added) { InvestorGroupCreated.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, sequence_number: 1) }
  let(:investor_added_to_investor_group) {
    InvestorAddedToInvestorGroup.new(
      aggregate_id: aggregate_id,
      investor_aggregate_id: investor_aggregate_id,
      sequence_number: 1
    )
  }

  before :each do
    LoanProjector.new.handle_message(LoanCreated.new(aggregate_id: loan_aggregate_id, investor_aggregate_id: investor_aggregate_id,
                                                     borrower_aggregate_id: borrower_aggregate_id, sequence_number: 1))
    MarketplaceProjector.new.handle_message(MarketplaceCreated.new(aggregate_id: marketplace_aggregate_id, loan_aggregate_id: loan_aggregate_id, sequence_number: 1))
  end

  context InvestorGroupCreated do
    it "creates a projection" do
      investor_group_projector.handle_message(investor_group_added)
      expect(InvestorGroup.count).to eq(1)
      record = InvestorGroup.first
      expect(record.aggregate_id).to eq(aggregate_id)
      expect(record.marketplace_aggregate_id).to eq(marketplace_aggregate_id)
    end
  end

  context InvestorGroupNameUpdated do
    let(:investor_group_name_updated) do
      InvestorGroupNameUpdated.new(aggregate_id: aggregate_id, name: "Test Investor Group Name", sequence_number: 2)
    end

    before { investor_group_projector.handle_message(investor_group_added) }

    it "updates a projection" do
      investor_group_projector.handle_message(investor_group_name_updated)
      expect(InvestorGroup.count).to eq(1)
      record = InvestorGroup.first
      expect(record.name).to eq("Test Investor Group Name")
    end
  end

  context InvestorGroupDescriptionUpdated do
    let(:investor_group_description_updated) do
      InvestorGroupDescriptionUpdated.new(aggregate_id: aggregate_id, description: "Test Investor Group Description", sequence_number: 2)
    end

    before { investor_group_projector.handle_message(investor_group_added) }

    it "updates a projection" do
      investor_group_projector.handle_message(investor_group_description_updated)
      expect(InvestorGroup.count).to eq(1)
      record = InvestorGroup.first
      expect(record.description).to eq("Test Investor Group Description")
    end
  end

  context InvestorAddedToInvestorGroup do
    before {
      investor_projector.handle_message(investor_created)
      investor_group_projector.handle_message(investor_group_added)
    }

    it "updates a projection" do
      investor_group_projector.handle_message(investor_added_to_investor_group)
      expect(InvestorGroup.count).to eq(1)
      record = InvestorGroup.first
      expect(record.investors.size).to eq(1)
      expect(record.investors.first.aggregate_id).to eq(investor_aggregate_id)
    end
  end

  context InvestorRemovedFromInvestorGroup do
    let(:investor_removed_from_investor_group) {
      InvestorRemovedFromInvestorGroup.new(
        aggregate_id: aggregate_id,
        investor_aggregate_id: investor_aggregate_id,
        sequence_number: 1
      )
    }

    before {
      investor_projector.handle_message(investor_created)
      investor_group_projector.handle_message(investor_group_added)
    }

    it "updates a projection" do
      investor_group_projector.handle_message(investor_added_to_investor_group)
      expect(InvestorGroup.count).to eq(1)
      record = InvestorGroup.first
      expect(record.investors.size).to eq(1)
      expect(record.investors.first.aggregate_id).to eq(investor_aggregate_id)

      investor_group_projector.handle_message(investor_removed_from_investor_group)
      expect(InvestorGroup.count).to eq(1)
      record = InvestorGroup.first
      expect(record.investors.size).to eq(0)
    end
  end
end

require_relative "../../../spec_helper"

describe InvestorProjector do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:investor_projector) { InvestorProjector.new }
  let(:investor_created) { InvestorCreated.new(aggregate_id: aggregate_id, sequence_number: 1) }
  let(:investor_deleted) { InvestorDeleted.new(aggregate_id: aggregate_id, sequence_number: 1) }

  context InvestorCreated do
    it "creates a projection" do
      investor_projector.handle_message(investor_created)
      expect(Investor.count).to eq(1)
      record = Investor.first
      expect(record.aggregate_id).to eq(aggregate_id)
    end
  end

  context InvestorDeleted do
    before { investor_projector.handle_message(investor_created) }

    it "updates a projection" do
      expect(Investor.count).to eq(1)
      record = Investor.first
      expect(record.aggregate_id).to eq(aggregate_id)

      investor_projector.handle_message(investor_deleted)
      expect(Investor.count).to eq(0)
    end
  end

  context InvestorNameUpdated do
    let(:investor_name_updated) do
      InvestorNameUpdated.new(aggregate_id: aggregate_id, name: "Test Name", sequence_number: 2)
    end

    before { investor_projector.handle_message(investor_created) }

    it "updates a projection" do
      investor_projector.handle_message(investor_name_updated)
      expect(Investor.count).to eq(1)
      record = Investor.first
      expect(record.name).to eq("Test Name")
    end
  end

  context InvestorDescriptionUpdated do
    let(:investor_description_updated) do
      InvestorDescriptionUpdated.new(aggregate_id: aggregate_id, description: "Test Description", sequence_number: 2)
    end

    before { investor_projector.handle_message(investor_created) }

    it "updates a projection" do
      investor_projector.handle_message(investor_description_updated)
      expect(Investor.count).to eq(1)
      record = Investor.first
      expect(record.description).to eq("Test Description")
    end
  end

  context InvestorFundingAmountUpdated do
    let(:investor_funding_amount_updated) do
      InvestorFundingAmountUpdated.new(aggregate_id: aggregate_id, funding_amount: 20_000_000.00, sequence_number: 2)
    end

    before { investor_projector.handle_message(investor_created) }

    it "updates a projection" do
      investor_projector.handle_message(investor_funding_amount_updated)
      expect(Investor.count).to eq(1)
      record = Investor.first
      expect(record.funding_amount).to eq(20_000_000.00)
    end
  end
end

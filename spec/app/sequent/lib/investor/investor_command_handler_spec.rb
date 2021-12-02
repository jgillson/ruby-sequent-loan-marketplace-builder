require_relative "../../../../spec_helper"

describe InvestorCommandHandler do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:name) { "ABC Bank"  }
  let(:description) { "A Bank" }
  let(:funding_amount) { 1_00_000.00 }

  before :each do
    Sequent.configuration.command_handlers = [InvestorCommandHandler.new]
  end

  context CreateInvestor do
    it "creates an investor" do
      when_command CreateInvestor.new(aggregate_id: aggregate_id, name: name, description: description, funding_amount: funding_amount)
      then_events InvestorCreated.new(aggregate_id: aggregate_id, sequence_number: 1),
                  InvestorNameUpdated,
                  InvestorDescriptionUpdated,
                  InvestorFundingAmountUpdated
    end
  end

  context EditInvestor do
    before { when_command CreateInvestor.new(aggregate_id: aggregate_id, name: name, description: description, funding_amount: funding_amount) }

    it "edits an investor" do
      when_command EditInvestor.new(aggregate_id: aggregate_id, name: "Updated Name", description: "Updated Description", funding_amount: 2_000_000.00)
      then_events InvestorCreated.new(aggregate_id: aggregate_id, sequence_number: 1),
                  InvestorNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  InvestorDescriptionUpdated.new(aggregate_id: aggregate_id, description: description, sequence_number: 2),
                  InvestorFundingAmountUpdated.new(aggregate_id: aggregate_id, funding_amount: funding_amount, sequence_number: 2),
                  InvestorNameUpdated.new(aggregate_id: aggregate_id, name: "Updated Name", sequence_number: 1),
                  InvestorDescriptionUpdated.new(aggregate_id: aggregate_id, description: "Updated Description", sequence_number: 1),
                  InvestorFundingAmountUpdated.new(aggregate_id: aggregate_id, funding_amount:2_000_000.00, sequence_number: 1)

    end
  end

  context DeleteInvestor do
    before { when_command CreateInvestor.new(aggregate_id: aggregate_id, name: name, description: description, funding_amount: funding_amount) }

    it "deletes an investor" do
      when_command DeleteInvestor.new(aggregate_id: aggregate_id)
      then_events InvestorCreated.new(aggregate_id: aggregate_id, sequence_number: 1),
                  InvestorNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  InvestorDescriptionUpdated.new(aggregate_id: aggregate_id, description: description, sequence_number: 1),
                  InvestorFundingAmountUpdated.new(aggregate_id: aggregate_id, funding_amount: funding_amount, sequence_number: 1),
                  InvestorDeleted.new(aggregate_id: aggregate_id, sequence_number: 1)
    end
  end
end

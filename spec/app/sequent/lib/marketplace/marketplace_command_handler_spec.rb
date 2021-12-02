require_relative "../../../../spec_helper"

describe MarketplaceCommandHandler do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:loan_aggregate_id) { Sequent.new_uuid }
  let(:name) { "The Marketplace" }

  before :each do
    Sequent.configuration.command_handlers = [MarketplaceCommandHandler.new]
  end

  context CreateMarketplace do
    it "creates a marketplace" do
      when_command CreateMarketplace.new(aggregate_id: aggregate_id, loan_aggregate_id: loan_aggregate_id, name: name)
      then_events MarketplaceCreated.new(aggregate_id: aggregate_id, loan_aggregate_id: loan_aggregate_id, name: name, sequence_number: 1),
                  MarketplaceNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2)
    end
  end

  context EditMarketplace do
    before { when_command CreateMarketplace.new(aggregate_id: aggregate_id, loan_aggregate_id: loan_aggregate_id, name: name) }

    it "edits a marketplace" do
      when_command EditMarketplace.new(aggregate_id: aggregate_id, name: "Updated Name")
      then_events MarketplaceCreated.new(aggregate_id: aggregate_id, loan_aggregate_id: loan_aggregate_id, sequence_number: 1),
                  MarketplaceNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  MarketplaceNameUpdated.new(aggregate_id: aggregate_id, name: "Updated Name", sequence_number: 1)
    end
  end

  context DeleteMarketplace do
    before { when_command CreateMarketplace.new(aggregate_id: aggregate_id, loan_aggregate_id: loan_aggregate_id, name: name) }

    it "deletes a marketplace" do
      when_command DeleteMarketplace.new(aggregate_id: aggregate_id)
      then_events MarketplaceCreated.new(aggregate_id: aggregate_id, loan_aggregate_id: loan_aggregate_id, sequence_number: 1),
                  MarketplaceNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  MarketplaceDeleted.new(aggregate_id: aggregate_id, sequence_number: 1)
    end
  end
end

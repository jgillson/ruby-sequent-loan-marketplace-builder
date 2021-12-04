require_relative "../../../../spec_helper"

describe InvestorGroupCommandHandler do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:marketplace_aggregate_id) { Sequent.new_uuid }
  let(:investor_aggregate_id) { Sequent.new_uuid }
  let(:name) { "The Investor Group" }
  let(:description) { "A group of investors" }

  before :each do
    Sequent.configuration.command_handlers = [InvestorGroupCommandHandler.new]
  end

  context AddInvestorGroup do
    it "creates an investor group" do
      when_command AddInvestorGroup.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, name: name, description: description)
      then_events InvestorGroupCreated.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, sequence_number: 1),
                  InvestorGroupNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  InvestorGroupDescriptionUpdated.new(aggregate_id: aggregate_id, description: description, sequence_number: 3)
    end
  end

  context EditInvestorGroup do
    before { when_command AddInvestorGroup.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, name: name, description: description) }

    it "edits an investor group" do
      when_command EditInvestorGroup.new(aggregate_id: aggregate_id, name: "Updated Name", description: "Updated Description")
      then_events InvestorGroupCreated.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, sequence_number: 1),
                  InvestorGroupNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  InvestorGroupDescriptionUpdated.new(aggregate_id: aggregate_id, description: description, sequence_number: 2),
                  InvestorGroupNameUpdated.new(aggregate_id: aggregate_id, name: "Updated Name", sequence_number: 1),
                  InvestorGroupDescriptionUpdated.new(aggregate_id: aggregate_id, description: "Updated Description", sequence_number: 1)
    end
  end

  context DeleteInvestorGroup do
    before { when_command AddInvestorGroup.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, name: name, description: description) }

    it "deletes an investor group" do
      when_command DeleteInvestorGroup.new(aggregate_id: aggregate_id)
      then_events InvestorGroupCreated.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, sequence_number: 1),
                  InvestorGroupNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  InvestorGroupDescriptionUpdated.new(aggregate_id: aggregate_id, description: description, sequence_number: 1),
                  InvestorGroupDeleted.new(aggregate_id: aggregate_id, sequence_number: 1)
    end
  end

  context AddInvestorToInvestorGroup do
    before { when_command AddInvestorGroup.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, name: name, description: description) }

    it "adds an investor to an investor group" do
      when_command AddInvestorToInvestorGroup.new(aggregate_id: aggregate_id, investor_aggregate_id: investor_aggregate_id)
      then_events InvestorGroupCreated.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, sequence_number: 1),
                  InvestorGroupNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  InvestorGroupDescriptionUpdated.new(aggregate_id: aggregate_id, description: description, sequence_number: 3),
                  InvestorAddedToInvestorGroup.new(aggregate_id: aggregate_id, investor_aggregate_id: investor_aggregate_id, sequence_number: 1)
    end
  end

  context RemoveInvestorFromInvestorGroup do
    before { when_command AddInvestorGroup.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, name: name, description: description) }

    it "removes an investor from an investor group" do
      when_command RemoveInvestorFromInvestorGroup.new(aggregate_id: aggregate_id, investor_aggregate_id: investor_aggregate_id)
      then_events InvestorGroupCreated.new(aggregate_id: aggregate_id, marketplace_aggregate_id: marketplace_aggregate_id, sequence_number: 1),
                  InvestorGroupNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  InvestorGroupDescriptionUpdated.new(aggregate_id: aggregate_id, description: description, sequence_number: 3),
                  InvestorRemovedFromInvestorGroup.new(aggregate_id: aggregate_id, investor_aggregate_id: investor_aggregate_id, sequence_number: 1)
    end
  end
end

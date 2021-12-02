require_relative "../../../../spec_helper"

describe LoanCommandHandler do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:borrower_aggregate_id) { Sequent.new_uuid }
  let(:investor_aggregate_id) { Sequent.new_uuid }
  let(:name) { "A Loan" }
  let(:amount) { 10_000_000.00 }

  before :each do
    Sequent.configuration.command_handlers = [LoanCommandHandler.new]
  end

  context CreateLoan do
    it "creates a loan" do
      when_command CreateLoan.new(aggregate_id: aggregate_id, borrower_aggregate_id: borrower_aggregate_id,
                                  investor_aggregate_id: investor_aggregate_id, name: name, amount: amount)
      then_events LoanCreated.new(aggregate_id: aggregate_id, borrower_aggregate_id: borrower_aggregate_id,
                                  investor_aggregate_id: investor_aggregate_id, name: name, amount: amount, sequence_number: 1),
                  LoanNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  LoanAmountUpdated.new(aggregate_id: aggregate_id, amount: amount, sequence_number: 2)
    end
  end

  context EditLoan do
    before { when_command CreateLoan.new(aggregate_id: aggregate_id, borrower_aggregate_id: borrower_aggregate_id,
                                         investor_aggregate_id: investor_aggregate_id, name: name, amount: amount) }

    it "edits a loan" do
      when_command EditLoan.new(aggregate_id: aggregate_id, name: "Updated Title", amount: 20_000_000.00)
      then_events LoanCreated.new(aggregate_id: aggregate_id, borrower_aggregate_id: borrower_aggregate_id,
                                  investor_aggregate_id: investor_aggregate_id, sequence_number: 1),
                  LoanNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  LoanAmountUpdated.new(aggregate_id: aggregate_id, amount: amount, sequence_number: 1),
                  LoanNameUpdated.new(aggregate_id: aggregate_id, name: "Updated Title", sequence_number: 2),
                  LoanAmountUpdated.new(aggregate_id: aggregate_id, amount: 20_000_000.00, sequence_number: 2)
    end
  end

  context DeleteLoan do
    before { when_command CreateLoan.new(aggregate_id: aggregate_id, borrower_aggregate_id: borrower_aggregate_id,
                                         investor_aggregate_id: investor_aggregate_id, name: name, amount: amount) }

    it "deletes a loan" do
      when_command DeleteLoan.new(aggregate_id: aggregate_id)
      then_events LoanCreated.new(aggregate_id: aggregate_id, borrower_aggregate_id: borrower_aggregate_id,
                                  investor_aggregate_id: investor_aggregate_id, sequence_number: 1),
                  LoanNameUpdated.new(aggregate_id: aggregate_id, name: name, sequence_number: 2),
                  LoanAmountUpdated.new(aggregate_id: aggregate_id, amount: amount, sequence_number: 2),
                  LoanDeleted.new(aggregate_id: aggregate_id, sequence_number: 1)
    end
  end
end

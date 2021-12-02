require_relative "../../../spec_helper"

describe LoanProjector do
  let(:aggregate_id) { Sequent.new_uuid }
  let(:borrower_aggregate_id) { Sequent.new_uuid }
  let(:investor_aggregate_id) { Sequent.new_uuid }
  let(:loan_projector) { LoanProjector.new }
  let(:loan_created) { LoanCreated.new(aggregate_id: aggregate_id, borrower_aggregate_id: borrower_aggregate_id,
                                       investor_aggregate_id: investor_aggregate_id, sequence_number: 1) }

  context LoanCreated do
    it "creates a projection" do
      loan_projector.handle_message(loan_created)
      expect(Loan.count).to eq(1)
      record = Loan.first
      expect(record.aggregate_id).to eq(aggregate_id)
      expect(record.borrower_aggregate_id).to eq(borrower_aggregate_id)
      expect(record.investor_aggregate_id).to eq(investor_aggregate_id)
    end
  end

  context LoanNameUpdated do
    let(:loan_name_updated) do
      LoanNameUpdated.new(aggregate_id: aggregate_id, name: "Test Loan Name", sequence_number: 2)
    end

    before { loan_projector.handle_message(loan_created) }

    it "updates a projection" do
      loan_projector.handle_message(loan_name_updated)
      expect(Loan.count).to eq(1)
      record = Loan.first
      expect(record.name).to eq("Test Loan Name")
    end
  end

  context LoanAmountUpdated do
    let(:loan_amount_updated) do
      LoanAmountUpdated.new(aggregate_id: aggregate_id, amount: 5_000_000.00, sequence_number: 2)
    end

    before { loan_projector.handle_message(loan_created) }

    it "updates a projection" do
      loan_projector.handle_message(loan_amount_updated)
      expect(Loan.count).to eq(1)
      record = Loan.first
      expect(record.amount).to eq(5_000_000.00)
    end
  end
end

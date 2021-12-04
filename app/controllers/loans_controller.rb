class LoansController < ApplicationController
  # Creates a loan
  def create
    loan_id = Sequent.new_uuid
    command = CreateLoan.from_params(loan_params.merge(aggregate_id: loan_id))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Updates a loan
  def update
    command = EditLoan.from_params(loan_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns a specific loan
  def show
    render json: Loan.find_by(aggregate_id: params[:id])
  end

  # Destroys a loan
  def destroy
    command = DeleteLoan.from_params(loan_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns all loans
  def index
    render json: Loan.all
  end

  # Returns the investor associated with a loan
  def investor
    render json: Loan.find_by(aggregate_id: params[:id])&.investor
  end

  # Returns the borrower associated with a loan
  def borrower
    render json: Loan.find_by(aggregate_id: params[:id])&.borrower
  end

  # Returns marketplaces associated with a loan
  def marketplaces
    render json: Loan.find_by(aggregate_id: params[:id])&.marketplaces
  end

  private

  def loan_params
    params.permit(:name, :investor_aggregate_id, :borrower_aggregate_id, :amount)
  end
end

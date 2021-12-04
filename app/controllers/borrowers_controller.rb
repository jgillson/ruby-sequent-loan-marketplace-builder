class BorrowersController < ApplicationController
  # Creates a borrower
  def create
    borrower_id = Sequent.new_uuid
    command = CreateBorrower.from_params(borrower_params.merge(aggregate_id: borrower_id))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Updates a borrower
  def update
    command = EditBorrower.from_params(borrower_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns a specific borrower
  def show
    render json: Borrower.find_by(aggregate_id: params[:id]).to_json
  end

  # Destroys a borrower
  def destroy
    command = DeleteBorrower.from_params(borrower_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns all borrowers
  def index
    render json: Borrower.all
  end

  # Returns loans associated with a borrower
  def loans
    render json: Borrower.find_by(aggregate_id: params[:id])&.loans
  end

  private

  def borrower_params
    params.permit(:name, :description, :requested_amount)
  end
end


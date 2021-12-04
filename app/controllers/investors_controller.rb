class InvestorsController < ApplicationController
  # Creates an investor
  def create
    investor_id = Sequent.new_uuid
    command = CreateInvestor.from_params(investor_params.merge(aggregate_id: investor_id))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Updates an investor
  def update
    command = EditInvestor.from_params(investor_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns a specific investor
  def show
    render json: Investor.find_by(aggregate_id: params[:id]).to_json
  end

  # Destroys an investor
  def destroy
    command = DeleteInvestor.from_params(investor_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns all investors
  def index
    render json: Investor.all
  end

  # Returns loans associated with an investor
  def loans
    render json: Investor.find_by(aggregate_id: params[:id])&.loans
  end

  # Returns investor groups associated with an investor
  def investor_groups
    render json: Investor.find_by(aggregate_id: params[:id])&.investor_groups
  end

  private

  def investor_params
    params.permit(:name, :description, :funding_amount)
  end
end

class InvestorGroupsController < ApplicationController
  # Creates an investor group
  def create
    investor_group_id = Sequent.new_uuid
    command = AddInvestorGroup.from_params(investor_group_params.merge(aggregate_id: investor_group_id))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Updates an investor group
  def update
    command = EditInvestorGroup.from_params(investor_group_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns a specific investor group
  def show
    render json: InvestorGroup.find_by(aggregate_id: params[:id])
  end

  # Destroys an investor group
  def destroy
    command = DeleteInvestorGroup.from_params(investor_group_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns all investor groups
  def index
    render json: InvestorGroup.all
  end

  # Returns investors associated with an investor group
  def investors
    render json: InvestorGroup.find_by(aggregate_id: params[:id])&.investors
  end

  # Adds an investor to an investor group
  def add_investor
    command = AddInvestorToInvestorGroup.from_params(investor_group_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Removes an investor from an investor group
  def remove_investor
    command = RemoveInvestorFromInvestorGroup.from_params(investor_group_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  private

  def investor_group_params
    params.permit(:name, :description, :investor_aggregate_id, :marketplace_aggregate_id)
  end
end

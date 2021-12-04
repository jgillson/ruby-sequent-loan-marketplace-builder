class MarketplacesController < ApplicationController
  # Creates a marketplace
  def create
    marketplace_id = Sequent.new_uuid
    command = CreateMarketplace.from_params(marketplace_params.merge(aggregate_id: marketplace_id))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Updates a marketplace
  def update
    command = EditMarketplace.from_params(marketplace_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns a specific marketplace
  def show
    render json: Marketplace.find_by(aggregate_id: params[:id])
  end

  # Destroys a marketplace
  def destroy
    command = DeleteMarketplace.from_params(marketplace_params.merge(aggregate_id: params[:id]))
    Sequent.command_service.execute_commands command
    render json: command.aggregate_id
  end

  # Returns all marketplaces
  def index
    render json: Marketplace.all
  end

  # Returns investor groups associated with a marketplace
  def investor_groups
    render json: Marketplace.find_by(aggregate_id: params[:id])&.investor_groups
  end

  # Returns investors associated with a marketplace
  def investors
    render json: Marketplace.find_by(aggregate_id: params[:id])&.investors
  end

  private

  def marketplace_params
    params.permit(:name, :loan_aggregate_id)
  end
end

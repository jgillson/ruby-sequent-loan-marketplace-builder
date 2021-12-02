# Ephemeral view tables (ActiveRecord models)
class Loan < ActiveRecord::Base
  belongs_to :borrower, foreign_key: :borrower_aggregate_id
  belongs_to :investor, foreign_key: :investor_aggregate_id
  has_many :marketplaces, foreign_key: :loan_aggregate_id, dependent: :destroy
  has_many :investor_groups, through: :marketplaces
  has_many :marketplace_investors, through: :investor_groups, source: :investors
end

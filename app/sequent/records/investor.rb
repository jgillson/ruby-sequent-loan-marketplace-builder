# Ephemeral view tables (ActiveRecord models)
class Investor < ActiveRecord::Base
  has_many :marketplaces, foreign_key: :loan_aggregate_id, dependent: :destroy
  has_many :loans, foreign_key: :investor_aggregate_id, dependent: :destroy
  has_many :loan_marketplaces, through: :loans, source: :marketplaces
  has_many :investor_groups, through: :loan_marketplaces
end

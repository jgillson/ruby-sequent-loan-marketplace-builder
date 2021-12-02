# Ephemeral view tables (ActiveRecord models)
class Marketplace < ActiveRecord::Base
  belongs_to :loan, foreign_key: :loan_aggregate_id
  has_many :investor_groups, foreign_key: :marketplace_aggregate_id, dependent: :destroy
  has_many :investors, through: :investor_groups
end

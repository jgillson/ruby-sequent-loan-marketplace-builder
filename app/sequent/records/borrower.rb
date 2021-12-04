# Ephemeral view tables (ActiveRecord models)
class Borrower < ActiveRecord::Base
  has_many :loans, foreign_key: :borrower_aggregate_id, dependent: :destroy
end

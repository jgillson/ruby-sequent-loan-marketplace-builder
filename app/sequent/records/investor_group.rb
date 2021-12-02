# Ephemeral view tables (ActiveRecord models)
class InvestorGroup < ActiveRecord::Base
  belongs_to :marketplace, foreign_key: :marketplace_aggregate_id
  has_and_belongs_to_many :investors, -> { distinct },
                          join_table: :investor_investor_groups,
                          association_foreign_key: :investor_aggregate_id,
                          foreign_key: :investor_group_aggregate_id
end

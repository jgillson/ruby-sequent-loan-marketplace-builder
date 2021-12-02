# Ephemeral view tables (ActiveRecord models)
class Borrower < ActiveRecord::Base
  has_many :loans
end

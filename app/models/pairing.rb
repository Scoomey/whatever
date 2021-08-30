class Pairing < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  belongs_to :food
end

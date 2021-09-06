class Food < ApplicationRecord
  has_many :pairings, dependent: :destroy
end

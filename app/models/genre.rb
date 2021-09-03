class Genre < ApplicationRecord
  has_many :movie_genres, dependent: :destroy
end

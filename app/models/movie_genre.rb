class MovieGenre < ApplicationRecord
  belongs_to :genre
  belongs_to :movie
end

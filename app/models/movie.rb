class Movie < ApplicationRecord

  has_many :pairing, dependent: :destroy
  has_many :movie_genres, dependent: :destroy
  has_many :genres, through: :movie_genres

end

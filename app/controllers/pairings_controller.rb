require 'json'
require 'open-uri'

class PairingsController < ApplicationController
  before_action :set_pairing, only: [:show, :edit, :update, :destroy]

  def index
    @pairings = Pairing.all
  end

  def new
    @pairing = Pairing.new
  end

  def create
    url2 = "https://api.spoonacular.com/recipes/complexSearch?apiKey=5236b678dfcc495f878449b8915b61f9&diet&query=#{params[:pairing][:food]}&number=1"
    food_url = URI.open(url2).read
    food_json = JSON.parse(food_url)

    foodtitle = food_json['results'][0]["title"]
    image = food_json['results'][0]["image"]

    @food = Food.create(dish: foodtitle, image: image)

    @food = Food.create(dish: params[:pairing][:food])
    @movie = Movie.find(params[:pairing][:movie_id])
    @pairing = Pairing.new(movie: @movie,food: @food)
    @pairing.user = current_user
    if @pairing.save
      redirect_to pairing_path(@pairing)
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    @pairing.update(pairing_params)
    redirect_to pairing_path(@pairing)
  end

  def destroy
    @pairing.destroy
    redirect_to pairings_path
  end

  def otp
    @movies = Movie.joins(:genres).select { |movie| movie.genres.map(&:name).any? { |genre| params[:otp].values.include?(genre)} }.uniq
    @movies = @movies.select { |movie| movie.year >= params[:otp][:minyear].to_i && movie.year <= params[:otp][:maxyear].to_i }
    @movies = @movies.sample

    url = "http://www.omdbapi.com/?t=#{@movies.title}&y=#{@movies.year}&apikey=b4c15d98"
    movie_url = URI.open(url).read
    movie_json = JSON.parse(movie_url)

    @title = movie_json["Title"]
    @plot = movie_json["Plot"]
    @year = movie_json["Year"]
    @genre = movie_json["Genre"]
    @poster = movie_json["Poster"]

    url_2 = "https://api.spoonacular.com/recipes/complexSearch?apiKey=5236b678dfcc495f878449b8915b61f9&minCalories=#{params[:otp][:minCalories]}&maxCalories=#{params[:otp][:maxCalories]}&intolerances=#{params[:otp][:intolerances]}&sort=random&number=1"
    url_3 = "https://api.spoonacular.com/recipes/complexSearch?apiKey=5236b678dfcc495f878449b8915b61f9&minCalories=#{params[:otp][:minCalories]}&maxCalories=#{params[:otp][:maxCalories]}&sort=random&number=1"
    url_4 = "https://api.spoonacular.com/recipes/complexSearch?apiKey=5236b678dfcc495f878449b8915b61f9&diet=#{params[:otp][:diet]}&minCalories=#{params[:otp][:minCalories]}&maxCalories=#{params[:otp][:maxCalories]}&intolerances=#{params[:otp][:intolerances]}&sort=random&number=1"
    if params[:otp][:diet] != ""
    food_url = URI.open(url_2).read
    food_json = JSON.parse(food_url)
    elsif params[:otp][:intolerances] != '' && params[:otp][:diet] != ""
    food_url = URI.open(url_3).read
    food_json = JSON.parse(food_url)
    else
    food_url = URI.open(url_4).read
    food_json = JSON.parse(food_url)
    end

    foodtitle = food_json['results'][0]["title"]
    image = food_json['results'][0]["image"]

    @foods = Food.new(dish: foodtitle, image: image)
  end

  def random_saying
    sayings = ["#{@title}, with #{@dish}, A Match made in heaven 😍", "Woah! #{@title}, and #{@dish}, who'd of thought?! 🧐", "#{@title}, and #{@dish} 4TW 👻", "#{@title}, and #{@dish}, can't argue with that?"]
    sayings.sample
  end
  private

  def set_pairing
    @pairing = Pairing.find(params[:id])
  end

  def pairing_params
    params.require(:pairing).permit(:movie, :food)
  end
end

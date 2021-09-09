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
    url2 = "https://api.spoonacular.com/recipes/complexSearch?apiKey=e6c9e40f09434dc3963a25a5886a39c9&diet&query=#{params[:pairing][:food]}&number=1"
    food_url = URI.open(url2).read
    food_json = JSON.parse(food_url)

    foodtitle = food_json['results'][0]["title"]
    image = food_json['results'][0]["image"]

    @food = Food.create(dish: foodtitle, image: image)
    @movie = Movie.find(params[:pairing][:movie_id])
    @pairing = Pairing.new(movie: @movie, food: @food)
    @pairing.user = current_user
    if @pairing.save
      redirect_to pairing_path(@pairing)
    else
      render 'new'
    end
  end

  def show
    @movies = @pairing.movie
    @foods = @pairing.food

    movie_info
  end

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

    movie_info

    url_2 = "https://api.spoonacular.com/recipes/complexSearch?apiKey=e6c9e40f09434dc3963a25a5886a39c9&diet=#{params[:otp][:diet]}&minCalories=#{params[:otp][:mincalories]}&maxCalories=#{params[:otp][:maxcalories]}&intolerances=#{params[:otp][:intolerances]}&type=mainCourse&sort=random&number=1"
    url_3 = "https://api.spoonacular.com/recipes/complexSearch?apiKey=e6c9e40f09434dc3963a25a5886a39c9&diet=#{params[:otp][:diet]}&minCalories=#{params[:otp][:mincalories]}&maxCalories=#{params[:otp][:maxcalories]}&type=mainCourse&sort=random&number=1"
    url_4 = "https://api.spoonacular.com/recipes/complexSearch?apiKey=e6c9e40f09434dc3963a25a5886a39c9&minCalories=#{params[:otp][:mincalories]}&maxCalories=#{params[:otp][:maxcalories]}&intolerances=#{params[:otp][:intolerances]}&type=mainCourse&sort=random&number=1"
    url_5 = "https://api.spoonacular.com/recipes/complexSearch?apiKey=e6c9e40f09434dc3963a25a5886a39c9&minCalories=#{params[:otp][:mincalories]}&maxCalories=#{params[:otp][:maxcalories]}&type=mainCourse&sort=random&number=1"
    if params[:otp][:intolerances] != '' && params[:otp][:diet] != ""
      food_url = URI.open(url_2).read
      food_json = JSON.parse(food_url)
    elsif params[:otp][:intolerances] == '' && params[:otp][:diet] != ""
      food_url = URI.open(url_3).read
      food_json = JSON.parse(food_url)
    elsif params[:otp][:diet] == "" && params[:otp][:intolerances] != ''
      food_url = URI.open(url_4).read
      food_json = JSON.parse(food_url)
    else
      food_url = URI.open(url_5).read
      food_json = JSON.parse(food_url)
    end

    foodtitle = food_json['results'][0]["title"]
    image = food_json['results'][0]["image"]
    @foodid = food_json['results'][0]["id"]

    @foods = Food.new(dish: foodtitle, image: image)

    sayings = ["#{@title} with #{foodtitle}, a match made in heaven 😍", "Woah! #{@title} and #{foodtitle}, who'd have thought?! 🧐", "#{@title} and #{foodtitle} FTW 👻", "#{@title} and #{foodtitle}, can't argue with that?!"]
    @saying = sayings.sample
  end

  private

  def set_pairing
    @pairing = Pairing.find(params[:id])
  end

  def pairing_params
    params.require(:pairing).permit(:movie, :food)
  end

  def movie_info
    url = "http://www.omdbapi.com/?t=#{@movies.title}&y=#{@movies.year}&apikey=b4c15d98"
    movie_url = URI.open(url).read
    movie_json = JSON.parse(movie_url)

    @title = movie_json["Title"]
    @plot = movie_json["Plot"]
    @year = movie_json["Year"]
    @genre = movie_json["Genre"]
    @poster = movie_json["Poster"]
  end
end

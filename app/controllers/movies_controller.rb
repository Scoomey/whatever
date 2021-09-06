class MoviesController < ApplicationController
  def show
  end

  def new
    # form to enter year and title
    # with this title and year do api call
    # render results of api call into movie partial
    # ajax? insert adjacent html?
    # ask to confirm
    # if no re-render the form
    # if yes Movie.create with the right params from form

  end

  private

  def confirm?
  end
end


# url = "http://www.omdbapi.com/?t=#{@movies.title}&y=#{@movies.year}&apikey=b4c15d98"
#     movie_url = URI.open(url).read
#     movie_json = JSON.parse(movie_url)

#     @title = movie_json["Title"]
#     @plot = movie_json["Plot"]
#     @year = movie_json["Year"]
#     @genre = movie_json["Genre"]
#     @poster = movie_json["Poster"]

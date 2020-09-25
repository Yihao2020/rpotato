class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
   
    if params[:ratings]
      @movies = Movie.where(:rating => params[:ratings].keys).find(:all, :order => (params[:sort]))
    end
    @all_ratings = Movie.all_ratings
    @set_ratings = params[:ratings]
    if !@set_ratings
      @set_ratings = Hash.new
    end
    
    @sort = params[:sort]
    if params[:sort] == "title"
      @movies = Movie.order(params[:sort])
      @title_class = "hilite"
    elsif params[:sort] =- "release_date"
      @movies = Movie.order(params[:sort])
      @release_date_class = "hilite"
    else
    @movies = Movie.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

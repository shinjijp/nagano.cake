class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to '/admin/genres'
  end

  def update
    @genre = Genre.find(params[:id])
    redirect_to '/admin/genres'
  end
  
  private
  # ストロングパラメータ
  def genre_params
    params.require(:genre).permit(:name)
  end
end

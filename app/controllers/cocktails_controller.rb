class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail) if params[:commit] == 'All done 🍸'
      redirect_to new_cocktail_dose_path(@cocktail) if params[:commit] == 'Add an ingedient'
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    if @cocktail.update(cocktail_params)
      redirect_to cocktail_path(@cocktail) if params[:commit] == 'All done'
      redirect_to new_cocktail_dose_path(@cocktail) if params[:commit] == 'Need more'
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, dose_attributes: [:description, :ingredient_id])
  end
end

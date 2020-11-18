class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new
    if @cocktail.save(cocktail_params)
      redirect_to cocktail_path(@cocktail) if params[:commit] == 'All done 🍸'
      render :edit
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
      if params[:more_ingredient]
        render :edit
      elsif @cocktail.update(cocktail_params)
        @cokctail.doses.last.delete if params[]
        redirect_to cocktail_path(@cocktail)
      end
    else
      render :edit
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, doses_attributes: [:description, :ingredient_id])
  end
end

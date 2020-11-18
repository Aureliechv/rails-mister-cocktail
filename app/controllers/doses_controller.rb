class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    if params[:dose][:description] == ''
      redirect_to edit_cocktail_path(@cocktail)
    elsif params[:dose][:ingredient_id] == ''
      redirect_to edit_cocktail_path(@cocktail)
    else
      @dose = Dose.new(dose_params)
      @ingredient = Ingredient.find(params[:dose][:ingredient_id])
      @dose.cocktail = @cocktail
      @dose.ingredient = @ingredient
      @dose.save
      redirect_to edit_cocktail_path(@cocktail)
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])
    @dose.delete
    redirect_to edit_cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end

class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      if params[:commit] == 'All done'
        redirect_to cocktail_path(@cocktail)
      elsif params[:commit] == 'Need more'
        redirect_to new_cocktail_dose_path(@cocktail)
      end
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.delete
    redirect_to cocktail_path
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end

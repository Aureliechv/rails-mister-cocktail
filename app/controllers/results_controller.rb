class ResultsController < ApplicationController
  def index
    redirect_to cocktails_path if params[:query].empty? == true
    @params = params[:query]
    @cocktails = Cocktail.joins(doses: :ingredient)
                         .where("cocktails.name ILIKE '%#{@params}%' OR ingredients.name ILIKE '%#{@params}%'")
                         .uniq
  end
end

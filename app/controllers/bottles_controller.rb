# frozen_string_literal: true

class BottlesController < ApplicationController
  def create
    wine_cellar = current_account.wine_cellars.find_by(id: params[:wine_cellar_id])
    return head :bad_request unless wine_cellar

    bottle = wine_cellar.bottles.new(bottle_params)
    if bottle.valid?
      bottle.save
    else
      render_errors(bottle)
    end
  end

  private

  def bottle_params
    params.permit(:name)
  end
end

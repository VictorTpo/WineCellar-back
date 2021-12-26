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

  def show
    @bottle = current_account.bottles.find_by(id: params[:id])
    return head :bad_request unless @bottle
  end

  def update
    bottle = current_account.bottles.find_by(id: params[:id])
    wine_cellar = current_account.wine_cellars.find_by(id: params[:wine_cellar_id])
    return head :bad_request unless bottle && wine_cellar

    bottle.update(bottle_params.merge(wine_cellar_id: params[:wine_cellar_id]))
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

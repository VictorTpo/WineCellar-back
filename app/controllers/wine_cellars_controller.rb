# frozen_string_literal: true

class WineCellarsController < ApplicationController
  def create
    wine_cellar = current_account.wine_cellars.new(wine_cellar_params)
    if wine_cellar.valid?
      wine_cellar.save
      render json: { name: wine_cellar.name }, status: 201
    else
      render_errors(wine_cellar)
    end
  end

  def show
    @wine_cellar = current_account.wine_cellars.find_by(id: params[:id])
    return head :not_found unless @wine_cellar
  end

  def index
    @wine_cellars = current_account.wine_cellars
  end

  def update
    wine_cellar = current_account.wine_cellars.find_by(id: params[:id])
    wine_cellar.update(wine_cellar_params)
    if wine_cellar.valid?
      wine_cellar.save
      head :ok
    else
      render_errors(wine_cellar)
    end
  end

  private

  def wine_cellar_params
    params.permit(:name)
  end
end

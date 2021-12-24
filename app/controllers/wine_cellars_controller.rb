# frozen_string_literal: true

class WineCellarsController < ApplicationController
  def create
    wine_cellar = WineCellar.new(wine_cellar_params)
    if wine_cellar.valid?
      wine_cellar.save
      render json: { name: wine_cellar.name }, status: 201
    else
      render_errors(wine_cellar)
    end
  end

  def show
    @wine_cellar = WineCellar.find_by(id: params[:id])
    return head :not_found unless @wine_cellar
  end

  private

  def wine_cellar_params
    params.permit(:name, :account_id)
  end
end

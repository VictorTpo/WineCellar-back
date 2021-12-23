# frozen_string_literal: true

class WineCellarsController < ApplicationController
  def create
    wine_cellar = WineCellar.new(wine_cellar_params)
    if wine_cellar.valid?
      wine_cellar.save
    else
      render_errors(wine_cellar)
    end
  end

  private

  def wine_cellar_params
    params.permit(:name, :account_id)
  end
end

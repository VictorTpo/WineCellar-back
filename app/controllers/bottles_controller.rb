# frozen_string_literal: true

class BottlesController < ApplicationController
  def create
    bottle = Bottle.new(bottle_params)
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

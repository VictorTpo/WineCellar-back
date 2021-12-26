# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate

  def new
    if params[:account_id]
      # todo
    elsif params[:google_id]
      account = Account.find_by(google_id: params[:google_id])
    else
      return head :unauthorized
    end

    return head :unauthorized unless account

    token = Session.new(account.id).generate_jwt_token
    render json: { token: token }, status: 200
  end
end

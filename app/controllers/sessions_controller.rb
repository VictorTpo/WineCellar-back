# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    @account = Account.find_by(email: params[:email])
    return head :unauthorized unless @account

    if @account.authenticate(params[:password])
      @jwt_token = Session.new(@account.id).generate_jwt_token
      render
    else
      head :unauthorized
    end
  end
end

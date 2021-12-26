# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate

  def create
    @account = Account.find_or_initialize_by(email: params[:email])

    if @account.persisted?
      @jwt_token = Session.new(@account.id).generate_jwt_token
      return render
    end

    @account.update(account_params)
    if @account.valid?
      @jwt_token = Session.new(@account.id).generate_jwt_token
      @account.save
      return render if @account.persisted?
    else
      render_errors(@account)
    end
  end

  private

  def account_params
    params.permit(:first_name, :last_name, :email, :google_id)
  end
end

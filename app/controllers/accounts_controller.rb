# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate

  def create
    @account = Account.new(account_params)

    @account.password = params[:password]

    if @account.valid?
      @account.save
    else
      render_errors(@account)
    end
  end

  private

  def account_params
    params.permit(:first_name, :last_name, :email)
  end
end

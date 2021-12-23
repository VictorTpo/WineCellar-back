# frozen_string_literal: true

class AccountsController < ApplicationController
  def create
    account = Account.find_or_initialize_by(email: params[:email])
    return head :ok if account.persisted?

    account.update(account_params)
    if account.valid?
      account.save
      head :ok
    else
      render_errors(account)
    end
  end

  private

  def account_params
    params.permit(:first_name, :last_name, :email, :google_id)
  end
end

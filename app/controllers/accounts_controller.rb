# frozen_string_literal: true

class AccountsController < ApplicationController
  def create
    @account = Account.find_or_initialize_by(email: params[:email])
    return render_account_id(200) if @account.persisted?

    @account.update(account_params)
    if @account.valid?
      @account.save
      render_account_id(201)
    else
      render_errors(@account)
    end
  end

  private

  def account_params
    params.permit(:first_name, :last_name, :email, :google_id)
  end

  def render_account_id(status)
    render json: { id: @account.id, first_name: @account.first_name }, status: status
  end
end

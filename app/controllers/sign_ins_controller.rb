# frozen_string_literal: true

class SignInsController < ApplicationController
  skip_before_action :require_login

  def show
    @service = SignInService.new(controller: self)

    skip_authorization
  end

  def create
    @service = SignInService.new(resource_params.merge(controller: self))

    skip_authorization

    if @service.save
      redirect_back_or_to characters_path, notice: "Successful signed in!"
    else
      # flash.now[:alert] = "Email and/or password is invalid"
      # flash[:alert] = "Email and/or password is invalid"

      render :show
    end
  end

  private

  def resource_params
    params.require(:sign_in)
      .permit(:email, :password, :remember_me)
  end
end

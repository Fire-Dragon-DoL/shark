# frozen_string_literal: true

require 'domain/sign_up'

class UsersController < ApplicationController
  def create
    sign_up_params = ::User::SignUp.build(params)

    unless sign_up_params.valid?
      render json: sign_up_params.errors.as_json, status: :unprocessable_entity
      return
    end

    if ::Domain::SignUp.(sign_up_params.name, sign_up_params.password)
      head :no_content
    else
      head :conflict
    end
  end
end

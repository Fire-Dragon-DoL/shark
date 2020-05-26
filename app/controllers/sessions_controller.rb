# frozen_string_literal: true

require 'domain/sign_in'

class SessionsController < ApplicationController
  def create
    sign_in_params = ::User::SignIn.build(params)

    unless sign_in_params.valid?
      render json: sign_in_params.errors.as_json, status: :unprocessable_entity
      return
    end

    token = ::Domain::SignIn.(sign_in_params.name, sign_in_params.password)

    render_token(token)
  end

  private

  def render_token(token)
    if token.nil?
      head :unauthorized
    else
      render json: { token: token }
    end
  end
end

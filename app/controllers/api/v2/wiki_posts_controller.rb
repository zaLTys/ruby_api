class Api::V2::WikiPostsController < ApplicationController
  def index
    render json: { 'message': 'in progress'}
  end
end

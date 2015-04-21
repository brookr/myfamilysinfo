class Api::V1::KidsController < ApplicationController
  def index
    # TODO: scope kids to current user
    @kids = Kid.all
    render json: @kids, status: 200
  end
end

class Api::V1::KidsController < ApplicationController
  def index
    # TODO: scope kids to current user
    @kids = Kid.all
    render json: @kids, status: 200
  end

  def show
    @kid = Kid.find(params[:id])
    render json: @kid, status: 200
  end

  def create
    @kid = Kid.new(kid_params)
    if @kid.save
      render json: @kid, status: 201
    end
  end

  protected

  def kid_params
    params.require(:kid).permit(:name, :dob, :insurance_id, :nurse_phone)
  end
end

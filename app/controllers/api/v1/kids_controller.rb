class Api::V1::KidsController < Api::V1::BaseController
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
    else
      render invalid_object_error(@kid)
    end
  end

  def update
    @kid = Kid.find(params[:id])
    if @kid.update(kid_params)
      render json: @kid, status: 201
    else
      render invalid_object_error(@kid)
    end
  end

  protected

  def kid_params
    params.permit(:name, :dob, :insurance_id, :nurse_phone)
  end
end

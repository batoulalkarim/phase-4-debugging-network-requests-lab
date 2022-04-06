class ToysController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  def show 
    toy = Toy.find(params[:id])
    render json: toy
  end

  def create
    toy = Toy.create(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = Toy.find_by(id: params[:id])
    toy.update!(toy_params)
    render json: toy
  end

  def destroy
    toy = Toy.find_by(id: params[:id])
    toy.destroy
    head :no_content
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_unprocessable_entity_response
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

end

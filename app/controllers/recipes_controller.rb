class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid,
              with: :render_unprocessable_entity_response


  def index

    recipes = Recipe.all
    render json: recipes, status: :created
  end

  def create
  user = User.find_by(id: session[:user_id])
  recipe = user.recipes.create!(create_params)
  render json: recipe, status: :created

  end

  private
  def create_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {
             errors: invalid.record.errors.full_messages
           },
           status: :unprocessable_entity
  end

end

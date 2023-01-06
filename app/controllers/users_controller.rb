class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    # Save a new user to the database with their username, encrypted password, image URL, and bio
    # Save the user's ID in the session hash
    # Return a JSON response with the user's ID, username, image URL, and bio; and an HTTP status code of 201 (Created)
    # If the user is not valid:
    # Return a JSON response with the error message, and an HTTP status code of 422 (Unprocessable Entity)
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    private
    
    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end

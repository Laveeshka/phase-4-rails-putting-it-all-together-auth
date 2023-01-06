class UsersController < ApplicationController
  skip_before_action :authorize, only: [:create]

  # action for our user to sign up
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

  # action for our user to stay logged in when they refresh the page or navigate back to your site from somewhere else
  # In the show action, if the user is logged in (if their user_id is in the session hash):
  # Return a JSON response with the user's ID, username, image URL, and bio; and an HTTP status code of 201 (Created)
  # If the user is not logged in when they make the request:
  # Return a JSON response with an error message, and a status of 401 (Unauthorized)
  def show
    user = User.find_by(id: session[:user_id])
    render json: user, status: :created
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

end

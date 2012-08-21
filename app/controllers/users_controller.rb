class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Profile saved'
      redirect_to @user
    else
      render 'show'
    end
  end
end

class UsersController < ApplicationController

  before_filter :validate_access

  def validate_access
    unless user_signed_in?
      redirect_to root_path, alert: 'You have to log in to be able to access that part of the website' and return
    end

    unless current_user.admin?
      redirect_to root_path, alert: 'You do not have access to that part of the website'
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendars }
    end
  end


  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])

    if @user == current_user
      redirect_to @user, alert: 'Please use the link in the panel named "Edit my account" to edit your own user.'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update

    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    @user = User.find(params[:id])


    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end

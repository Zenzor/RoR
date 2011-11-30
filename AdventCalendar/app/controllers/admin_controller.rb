class AdminController < ApplicationController

  before_filter :check_if_admin

  protected

  def check_if_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path, alert: 'You do not have permission to access this part of the website!'
    end
  end

  public

  def index
    @calendars = Calendar.all
    @users = User.all
  end

  def show_users

    name = "%#{params[:n]}%"
    surname = "%#{params[:sn]}%"

    @users = User.where("name LIKE ? AND surname LIKE ?", name, surname)

    if @users.size == 1
      redirect_to @users.first
    end

  end

end

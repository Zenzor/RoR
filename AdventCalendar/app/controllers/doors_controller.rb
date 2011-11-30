class DoorsController < ApplicationController

  before_filter :check_open_date

  def show
    @calendar = Calendar.find(@door.calendar_id)

    unless @calendar.public?
      if user_signed_in?
        unless @calendar.user_id == current_user.id || current_user.admin?
          redirect_to root_path, alert: "You are not allowed to access that part of the site!"
        end
      else
        redirect_to root_path, alert: "You have to be signed in before you can access that part of the site!!"
      end
    end
  end

  private

  def check_open_date
    @door = Door.find(params[:id])
    if @door.unlock_date.future?
      redirect_to root_path, notice: "You cannot open this door yet!"
    end
  end

end

class CalendarsController < ApplicationController

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.all
    @users = User.all

    if user_signed_in?

      @shared_calendars = current_user.calendars

      @user_calendars = Calendar.find_all_by_user_id(current_user.id)

    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendars }
    end
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
    @calendar = Calendar.find(params[:id])

    unless @calendar.public?
      if user_signed_in?
        unless @calendar.user_id == current_user.id || current_user.calendars.includes(@calendar)
          redirect_to root_path, alert: 'You do not have permission to access this calendar!' and return
        end
      else
        redirect_to root_path, alert: 'You have to log in before you can access a private calendar' and return
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/new
  # GET /calendars/new.json
  def new
    @calendar = Calendar.new

    @users = User.where("id <> #{current_user.id}")

    24.times { @calendar.doors.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/1/edit
  def edit
    @calendar = Calendar.find(params[:id])
    @users = User.where("id <> #{current_user.id}")
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(params[:calendar])
    @calendar.update_attribute :user_id, current_user.id

    params[:doors].each_value do |door|
      @calendar.doors.build(door)
    end

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render json: @calendar, status: :created, location: @calendar }
      else
        format.html { render action: "new" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calendars/1
  # PUT /calendars/1.json
  def update
    @calendar = Calendar.find(params[:id])

    @calendar.doors.destroy_all
    params[:doors].each_value do |door|
      @calendar.doors.build(door)
    end

    @calendar.user_ids = params[:user_ids]

    respond_to do |format|
      if @calendar.update_attributes(params[:calendar])
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar = Calendar.find(params[:id])
    @calendar.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end
end

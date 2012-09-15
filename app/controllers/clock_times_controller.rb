class ClockTimesController < ApplicationController
  # GET /clock_times
  # GET /clock_times.json
  def index
    @clock_times = ClockTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clock_times }
    end
  end

  # GET /clock_times/1
  # GET /clock_times/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clock_time }
    end
  end

  # GET /clock_times/new
  # GET /clock_times/new.json
  def new
    @user = User.find(params[:user_id])
    @clock_time = @user.clock_times.new(:in => Time.now)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clock_time }
    end
  end

  # GET /clock_times/1/edit
  def edit
    @user = User.find(params[:user_id])
    @clock_time = @user.clock_times.find(params[:id])

    @clocking_out = params[:clock_out]
  end

  # POST /clock_times
  # POST /clock_times.json
  def create
    @user = User.find(params[:user_id])
    @clock_time = @user.clock_times.new(params[:clock_time])

    time_in_to_update = get_time_to_update(params["use_current"], params[:clock_time], "in")


    @clock_time.in = time_in_to_update

    respond_to do |format|
      if @clock_time.save
        format.html { redirect_to @user, notice: 'You have successfully clocked in' }
        format.json { render json: @clock_time, status: :created, location: @clock_time }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @clock_time.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /clock_times/1
  # PUT /clock_times/1.json
  def update
    @user = User.find(params[:user_id])
    @clock_time = @user.clock_times.find(params[:id])

    time_in_to_update = get_time_to_update(params["use_current"], params[:clock_time], "in")

    @clock_time.in = time_in_to_update

    time_out_to_update = get_time_to_update(params["use_current_out"], params[:clock_time], "out")

    if !time_out_to_update.nil?
      @clock_time.out = time_out_to_update
    end

    respond_to do |format|
      if @clock_time.update_attributes(params[:clock_time])
        format.html { redirect_to @user, notice: 'Your clock in time was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clock_time.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_time_to_update(use_current, clock_time, which)
    if use_current == 'true'
      return Time.now
    else
      if clock_time[which + "(1i)"].present?
        return Time.parse(clock_time[which + "(1i)"].to_s + "-" + clock_time[which + "(2i)"].to_s + "-" +
                              clock_time[which + "(3i)"].to_s + " " + clock_time[which + "(4i)"].to_s + ":" + clock_time[which + "(5i)"].to_s)
      else
        return nil
      end
    end
  end

  # DELETE /clock_times/1
  # DELETE /clock_times/1.json
  def destroy
    @user = User.find(params[:user_id])
    @clock_time = @user.clock_times.find(params[:id])
    @clock_time.destroy

    respond_to do |format|
      format.html { redirect_to user_path(@user) }
      format.js {render json: @clock_time, content_type: 'text/json' }
    end


  end
end

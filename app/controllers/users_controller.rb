class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1DIS
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    @clock_times = @user.clock_times.all
    @clock_times_by_week = separate_by_weeks @clock_times
    puts "farg..." + @clock_times_by_week.inspect
    @clock_time = @user.clock_times.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def separate_by_weeks clock_times
    week_hash = Hash.new {|hash,key| hash[key] = [] }

    for clock_time in clock_times
      week_hash[clock_time.in.strftime("%Y-%U")].push clock_time
    end

    week_hash
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    params[:user]["_id"] = params[:user][:name]
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save()
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
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
      format.json { head :no_content }
      puts "*************:" + @user.inspect
      format.js { render nothing: true }
    end
  end

  def auto_clock_in
    @user = User.find(params[:user_id])

    @clock_times = @user.clock_times.all

    @already_clocked_in = is_user_already_clocked_in @clock_times



    if @already_clocked_in
      redirect_to @user, notice: 'You have already clocked in, and cannot again until you clock out'
    else
      @clock_time = @user.clock_times.new(:in => Time.now)

      respond_to do |format|
        if @clock_time.save
          format.html { redirect_to @user, notice: 'You have successfully clocked in' }
          format.json { render json: @clock_time, status: :created, location: @clock_time }
        else
          format.html { render action: "new" }
          format.json { render json: @clock_time.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  def is_user_already_clocked_in clock_times
    already_clocked_in = false

    for clock_time in clock_times
      if clock_time.out.nil?
        already_clocked_in = true
      end
    end

    already_clocked_in
  end

  def get_last_clocked_in_clock_time clock_times
    for clock_time in clock_times
      if clock_time.out.nil?
        break
      end
      clock_time = nil
    end

    clock_time
  end

  def auto_clock_out
    @user = User.find(params[:user_id])

    puts @user.inspect


    @clock_times = @user.clock_times.all

    @last_clock_time = get_last_clocked_in_clock_time @clock_times

    if !@last_clock_time.nil?
      @clock_time = @user.clock_times.find(@last_clock_time.id)

      respond_to do |format|
        if @clock_time.update_attributes(:out => Time.now)
          format.html { redirect_to @user, notice: 'You were successfully clocked out.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @clock_time.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to @user, notice: "You cannot clock out, since you haven't been clocked in yet"
    end

  end
end

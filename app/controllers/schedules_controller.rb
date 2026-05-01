class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[ show edit update destroy ]

  # GET /schedules or /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1 or /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new(room_id: params[:room_id])
    @room = Room.find(params[:room_id]) if params[:room_id].present?
  end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
    @room = @schedule.room
  end

  # POST /schedules or /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    respond_to do |format|
      if @schedule.save
        @room = Room.find(@schedule.room_id) if @schedule.room_id
        format.html { redirect_to room_path(@room), notice: "Schedule was successfully created." }
        format.json { render :show, status: :created, location: @schedule }
      else
        @room = Room.find(@schedule.room_id) if @schedule.room_id
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1 or /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        @room = Room.find(@schedule.room_id) if @schedule.room_id
        format.html { redirect_to room_path(@room), notice: "Schedule was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1 or /schedules/1.json
  def destroy
    @room = @schedule.room
    @schedule.destroy!

    respond_to do |format|
      format.html { redirect_to room_path(@room), notice: "Schedule was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.expect(schedule: [ :room_id, :start_time, :end_time, :description, :status, :start_date, :end_date, frequency: [] ])
    end
end

class DailyUsagesController < ApplicationController
  before_action :set_daily_usage, only: [:show, :edit, :update, :destroy]

  # GET /daily_usages
  # GET /daily_usages.json
  def index
    @daily_usages = DailyUsage.all
  end

  # GET /daily_usages/1
  # GET /daily_usages/1.json
  def show
  end

  # GET /daily_usages/new
  def new
    @daily_usage = DailyUsage.new
  end

  # GET /daily_usages/1/edit
  def edit
  end

  # POST /daily_usages
  # POST /daily_usages.json
  def create
    @daily_usage = DailyUsage.new(daily_usage_params)

    respond_to do |format|
      if @daily_usage.save
        format.html { redirect_to @daily_usage, notice: 'Daily usage was successfully created.' }
        format.json { render :show, status: :created, location: @daily_usage }
      else
        format.html { render :new }
        format.json { render json: @daily_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_usages/1
  # PATCH/PUT /daily_usages/1.json
  def update
    respond_to do |format|
      if @daily_usage.update(daily_usage_params)
        format.html { redirect_to @daily_usage, notice: 'Daily usage was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_usage }
      else
        format.html { render :edit }
        format.json { render json: @daily_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_usages/1
  # DELETE /daily_usages/1.json
  def destroy
    @daily_usage.destroy
    respond_to do |format|
      format.html { redirect_to daily_usages_url, notice: 'Daily usage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_usage
      @daily_usage = DailyUsage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_usage_params
      params.require(:daily_usage).permit(:price)
    end
end

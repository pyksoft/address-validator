class SettingsController < ApplicationController
  before_action :set_setting, only: [:edit, :update, :destroy]

  # GET /settings
  # GET /settings.json
  def index
    @settings = Setting.all
  end

  # GET /settings/1
  # GET /settings/1.json

  def show
    @setting = Setting.find_by store_domain: params[:shop]
    add_cors_headers
    render json: {setting: @setting.as_json(:except => [:id, :created_at, :updated_at, :store_domain])}, status: :ok
  end

  def add_history
    add_cors_headers
    @history = History.new(shipping_address: params[:address], shop: params[:shop])
    @history.save
    render json: {status: 'ok'}
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to edit_setting_path(@setting), notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:auto_complete, :validate_address, :pobox_warning, :streetnum_warning, :store_domain, :color_background, :color_border, :color_text, :color_background_warning, :color_border_warning, :color_text_warning, :color_highlight, :color_hover, :text_apt_suite, :text_inaccurate, :text_select_confirm, :text_select_suggestion, :text_suggest1, :text_suggest2, :text_correct, :text_pobox_warning, :text_streetnum_warning)
    end

    def add_cors_headers
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      response.headers['Access-Control-Request-Method'] = '*'
      response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
end

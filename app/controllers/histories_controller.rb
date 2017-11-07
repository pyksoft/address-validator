class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]

  # GET /histories
  # GET /histories.json
  def index
    @histories = History.all
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # GET /histories/new
  def new
    @history = History.new
  end

  def add_history
    add_cors_headers
    puts "---------------#{params[:shop]}--------#{params[:address]}--------------------"
    @history = History.new(shipping_address: params[:address], shop: params[:shop])
    @history.save
    render json: {status: 'ok'}
  end

  # GET /histories/1/edit
  def edit
  end

  def usage_charge
    usage_price = 0;
    HistoriesController.create_usage_charge(price: usage_price)
  end

  # POST /histories
  # POST /histories.json
  def create
    @history = History.new(history_params)
    respond_to do |format|
      if @history.save
        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.json { render :show, status: :created, location: @history }
      else
        format.html { render :new }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:country, :shipping_address, :shop)
    end

    def add_cors_headers
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      response.headers['Access-Control-Request-Method'] = '*'
      response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
end

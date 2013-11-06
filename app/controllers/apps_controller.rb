class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /apps
  # GET /apps.json
  def index
    @apps = App.all.order("created_at DESC")
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
  end

  # GET /apps/new
  def new
    #@app = App.new
    @app = current_user.apps.build
  end

  # GET /apps/1/edit
  def edit
  end

  # POST /apps
  # POST /apps.json
  def create
    #@app = App.new(app_params)
    @app = current_user.apps.build(app_params)
    respond_to do |format|
      if @app.save
        format.html { redirect_to @app, notice: 'App was successfully created.' }
        format.json { render action: 'show', status: :created, location: @app }
      else
        format.html { render action: 'new' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy
    redirect_to apps_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end
    
    def correct_user
      @app = current_user.apps.find_by(id: params[:id])
      redirect_to apps_path, notice: "Not authorized to edit this pin" if @app.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      # Roland: you need to add other parameters.
      params.require(:app).permit(:trackId, :trackViewURL, :trackName, :icon)
    end
end

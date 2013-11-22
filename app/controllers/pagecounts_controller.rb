class PagecountsController < ApplicationController
  before_action :set_pagecount, only: [:index]

  # GET /pagecounts
  # GET /pagecounts.json
  def index
    @pagecounts = @app.pagecounts.order("mixpanel_data DESC")

    #@pagecounts = Pagecount.find_by_app_id(@app)
  end

  # GET /pagecounts/1
  # GET /pagecounts/1.json
  def show
  end

  # GET /pagecounts/new
  def new
    @pagecount = Pagecount.new
  end

  # GET /pagecounts/1/edit
  def edit
  end

  # POST /pagecounts
  # POST /pagecounts.json
  def create
    @pagecount = Pagecount.new(pagecount_params)

    respond_to do |format|
      if @pagecount.save
        format.html { redirect_to @pagecount, notice: 'Pagecount was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pagecount }
      else
        format.html { render action: 'new' }
        format.json { render json: @pagecount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pagecounts/1
  # PATCH/PUT /pagecounts/1.json
  def update
    respond_to do |format|
      if @pagecount.update(pagecount_params)
        format.html { redirect_to @pagecount, notice: 'Pagecount was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pagecount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagecounts/1
  # DELETE /pagecounts/1.json
  def destroy
    @pagecount.destroy
    respond_to do |format|
      format.html { redirect_to pagecounts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pagecount  
      @app = App.find(params[:app_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def pagecount_params
      params.require(:pagecount).permit(:pageview)
    end
end

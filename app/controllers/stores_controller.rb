class StoresController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction



  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
    @stores = Store.search(params[:search],params[:fieldtype]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    @map_hash = Gmaps4rails.build_markers(@stores) do |store, marker|
      marker.lat store.latitude
      marker.lng store.longitude
      marker.infowindow store.title
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(user_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(user_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    Store.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @store = Store.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:store).permit(:latitude, :longitude, :name, :adress, :title)
  end
end

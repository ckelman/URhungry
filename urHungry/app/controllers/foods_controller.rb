class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show]
  before_filter :admin_only, :except => [:show]

  # GET /foods
  # GET /foods.json
  def index
    @foods = Food.all
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
    @reviews = @food.reviews.sort_by{|e| e[:title]}
    #@rating = Rating.where(food_id: @food.id, user_id: current_user).first
    #unless @rating
    #  @rating = Rating.create(food_id: @food.id, user_id: current_user, score: 0)
    #end
  end

  # GET /foods/new
  def new
    @myPlace = params[:my_place]
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit
    @myPlace = @food.place.id
  end
  
  # POST /foods
  # POST /foods.json
  def create
    @food = Food.new(food_params)
    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render action: 'show', status: :created, location: @food }
      else
        format.html { render action: 'new' }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1
  # PATCH/PUT /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:name, :place_id)
    end
    
    def admin_only
    if(!current_user.is_admin)
      redirect_to :controller => "welcome", :action => "index"
    end
  end
end
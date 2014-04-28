class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, :except => [:show]
  before_filter :owner_only, :except => [:show]
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @myFood = params[:my_food]
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    @myFood = @review.food.id
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    
    if @review.title == ''
      @review.title = "Untitled"
    end
    
    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @review }
      else
        format.html { render action: 'new' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update    
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
    
    if @review.title == ''
      @review.title = "Untitled"
      @review.save
    end
    
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @food = @review.food
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @food }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:title, :body, :rating, :user_id, :food_id)
    end
    
    def owner_only
      if(@review != nil && current_user != @review.user)
        redirect_to :controller => "welcome", :action => "index"
      end
    end
end

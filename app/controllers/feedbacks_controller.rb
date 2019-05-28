class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :update, :destroy]
  after_action :update_product_score, only: [:create]

  def index
    @feedbacks = Feedback.all

    render json: @feedbacks
  end

  def show
    render json: @feedback
  end

  def create
    email = params[:email]
    product = params[:product]
    user = User.find_by_email(email)
    @product = Product.find_by_name(product)
    feed_params = {rating: params[:rating], description: params[:description], product_id: @product.id, user_id: user.id }
    @feedback = Feedback.new(feed_params)
    if @feedback.save
      render json: @feedback, status: :created, location: @feedback
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  def update_product_score
    review_count = @product.review_count
    @product.internal_score = ((@product.internal_score)*review_count + @feedback.rating)/(review_count+1) #update product score(average)
    @product.review_count = review_count+1
    @product.save!
  end

  def update
    if @feedback.update(feedback_params)
      render json: @feedback
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @feedback.destroy
  end

  private
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    def feedback_params
      params.require(:feedback).permit(:rating, :description, :product_id, :user_id)
    end
end

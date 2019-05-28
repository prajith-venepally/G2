class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  def get_feed
    email = params[:email]
    @user = User.find_by_email(email)
    persona = params[:persona] || @user.category.name
    #sub_categories = category.sub_categories.includes(:products)
    #sub_categories.each do |sub_category|
    #  products << sub_category.products
    #end
    category = Category.find_by_name(persona)
    sub_categories = category.sub_categories.pluck(:id)
    products = Product.where(sub_category: sub_categories).order(internal_score: :desc)
    unless @user
      User.create(email: email, category: category)
      render json: {"products" => products}
    else
      render json: {"products" => non_first_time_user_feed(products)}
    end
    #render json: {"products" => products}
  end

  private
    
    # define score for products based on user feedback and search history.
    def non_first_time_user_feed products
      #generate raking based on the search, bookmarks and feedback 
      searches = @user.searches.limit(3)
      feedbacks = @user.feedbacks
      bookmarks = @user.bookmarks
      results = Hash.new
      products.each do |product|
        score = product.internal_score
        bookmarks.each do |bookmark|
          if bookmark.product_id == product.id
            score += 2 #bookmarked products should be on top so adding extra
          end
        end
        feedbacks.each do |feedback|
          if feedback.product_id == product.id
            score += (feedback.rating - 3) #considering 3 rating as average
          elsif feedback.product.sub_category_id == product.sub_category_id
            score += (3 - feedback.rating) #For postive feedback user might not want to see other products in that sub_category at top, for negative feedback reverse
          end 
        end
        searches.each do |search|
          if search.searchable_type == 'Product'
            if search.searchable_id == product.id
              score += 2 #latest search products at top
            end
          else
            if search.searchable_id == product.sub_category_id
              score += 1 #latest serach subcategory products at top
            end
          end
        end
        results[score] = results.key?(score) ? results[score] + [product] : [product]
      end
      results = results.sort.reverse.to_h
      result_array = Array.new
      results.each do |key, value| 
        result_array += value
      end
      result_array
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :category_id)
    end
end

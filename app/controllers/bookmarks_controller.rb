class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :update, :destroy]

  # GET /bookmarks
  def index
    @bookmarks = Bookmark.all

    render json: @bookmarks
  end

  # GET /bookmarks/1
  def show
    render json: @bookmark
  end

  def create
      email = params[:email]
      product = params[:product]
      user = User.find_by_email(email)
      product = Product.find_by_name(product)
      bookmark = Bookmark.new(user: user, product: product)
      if bookmark.save
        render json: bookmark, status: :created, location: bookmark
      else
        render json: bookmark.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /bookmarks/1
  def update
    if @bookmark.update(bookmark_params)
      render json: @bookmark
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookmarks/1
  def destroy
    @bookmark.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bookmark_params
      params.require(:bookmark).permit(:user_id, :product_id)
    end
end

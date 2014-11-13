class ReviewsController < ApplicationController
	before_action :admin_user, only: [:create,:show_review,:edit,:update,:destroy]
	include ApplicationHelper

	def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = "Ваш отзыв отправлен"
    else
      flash[:danger] = "Ошибка! Ваш отзыв не отправлен"
    end
    @reviews = Review.where(show: true)
    @new_review = Review.new
    respond_to do |format|
    	format.js
    end
	end

  def show_review
  	@review = Review.find(params[:id])
    @reviews = Review.all
    @review.update_attributes(show: to_boolean(params[:show])) if Review.where(show: true).count < 4 and to_boolean(params[:show]) or to_boolean(params[:show]) == false
    respond_to do |format|
    	format.js
    end
  end

  def destroy
  	@reviews = Review.all
    @review = Review.find(params[:id])
    @review.destroy
    respond_to do |format|
    	format.js
    end
  end

  def edit
    @review = Review.find(params[:id])
    respond_to do |format|
    	format.js
    end
  end

  def update
    @review = Review.find(params[:id])
    @reviews = Review.all
    @review.update_attributes(name: params[:name], text: params[:text])
    @review.update_attributes(image: params[:image]) unless params[:image].blank?
    respond_to do |format|
    	format.js
    end
  end

  private

    def review_params
      params.require(:review).permit(:name, :text, :image, :email)
    end


    def admin_user
      unless is_admin?
        raise ActionController::RoutingError.new('Not Found')
      end
    end

end

class FaqsController < ApplicationController
	before_action :admin_user, only: [:create,:show_faq,:edit,:update,:destroy]
	include ApplicationHelper
	
	def create
    @faq = Faq.new(question: params[:question], answer: params[:answer])
    @faqs = Faq.all
    @faq.save
    respond_to do |format|
    	format.js
    end
  end

  def show_faq
  	@faq = Faq.find(params[:id])
    @faqs = Faq.all
    @faq.update_attributes(show: to_boolean(params[:show])) if Faq.where(show: true).count < 6 and to_boolean(params[:show]) or to_boolean(params[:show]) == false
    respond_to do |format|
    	format.js
    end
  end
  
  def edit
    @faq = Faq.find(params[:id])
    respond_to do |format|
    	format.js
    end
  end

  def update
    @faq = Faq.find(params[:id])
    @faqs = Faq.all
    @faq.update_attributes(answer: params[:answer], question: params[:question])
    respond_to do |format|
    	format.js
    end
  end

  def destroy
    @faqs = Faq.all
    @faq = Faq.find(params[:id])
    @faq.destroy
    respond_to do |format|
    	format.js
    end
  end

  private

    def admin_user
      unless is_admin?
        raise ActionController::RoutingError.new('Not Found')
      end
    end

end

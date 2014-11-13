class OffersController < ApplicationController
  include ApplicationHelper
  before_action :admin_user, only: [:create,:offer_position,:edit,:update,:destroy]

  def create
    @offer = Offer.create(title: params[:title],description: params[:description], image: params[:image], old_price: params[:old_price].to_f, new_price: params[:new_price].to_f, end_at: params[:end_at])
    @offers = Offer.all
    if @offer.save
      feature_titles = params[:feature_titles]
      for i in 0..2
        if feature_titles[i.to_s].blank?
        	break
        else 
          Feature.create(offer_id: @offer.id, title: feature_titles[i.to_s])        
        end
      end
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @offer = Offer.find(params[:id])
    respond_to do |format|
    	format.js
    end
  end 

  def offer_position
    @offer = Offer.find(params[:id])
    @offers = Offer.all
    if params[:position].to_i == 1
      @offer.update_attributes(position: params[:position].to_i) if @offers.where(position: 1).count < 3
    elsif params[:position].to_i == 2
      @offer.update_attributes(position: params[:position].to_i) if @offers.where(position: 2).count < 1
    else
      @offer.update_attributes(position: params[:position].to_i)	
    end
    respond_to do |format|
    	format.js
    end
  end

  def update
    @offer = Offer.find(params[:id])
    @offers = Offer.all
    if @offer.update_attributes(title: params[:title], description: params[:description], old_price: params[:old_price], new_price: params[:new_price], end_at: params[:end_at])
    	@offer.update_attributes(image: params[:image]) unless params[:image].blank?
    	feature_titles = params[:feature_titles]
    	feature_titles.each_key do |id|
	      begin
		    	if feature = Feature.find(id)
		        feature.update_attributes(title: feature_titles[id])
		    	end
	      rescue ActiveRecord::RecordNotFound
	        unless feature_titles[id].blank?
	        	Feature.create(title: feature_titles[id], offer_id: @offer.id)
	    	  end
	      end  	
    	end
    	respond_to do |format|
      		format.js
    	end
    end	
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy
    @offers = Offer.all
    respond_to do |format|
    	format.js
    end
  end

  def order_new
    @offer = Offer.find(params[:id])
    respond_to do |format|
        format.js
    end
  end

  def order_create
    Mailer.OfferOrder(params[:name],params[:email],params[:phone],params[:payment],params[:id],params[:adress],params[:index],params[:city]).deliver
    @payment = params[:payment]
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

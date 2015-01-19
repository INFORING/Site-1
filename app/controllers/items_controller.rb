class ItemsController < ApplicationController
  before_action :admin_user, only: [:create,:show_item,:edit,:update,:destroy,:preorder_create,:preorder_update]

  include ApplicationHelper

  def create
    @item = Item.create(title: params[:title],description: params[:description], image: params[:image], price: params[:price].to_i)
    @items = Item.all
    if @item.save
    	feature_titles = params[:feature_titles]
      for i in 0..7
        if feature_titles[i.to_s].blank?
        	break
        else 
          Feature.create(item_id: @item.id, title: feature_titles[i.to_s])        
        end
      end
    else
      flash[:danger] = "Ошибка! Проверьте заполнены ли все поля"
    end
    respond_to do |format|
        format.js
    end
  end
  
  def show_item
    @item = Item.find(params[:id])
    @items = Item.all
    priority = Item.where(show:true).count
    if Item.where(show: true).count < 3 and to_boolean(params[:show]) or to_boolean(params[:show]) == false
      @item.update_attributes(show: to_boolean(params[:show]))
      if to_boolean(params[:show]) == true
        @item.update_attributes(priority: priority + 1)
      else
      	@item.update_attributes(priority: 0)
      end
    end
    respond_to do |format|
    	format.js
    end
  end   

  def edit
    @item = Item.find(params[:id])
    respond_to do |format|
    	format.js
    end
  end 

  def update
    @item = Item.find(params[:id])
    @items = Item.all
    if @item.update_attributes(title: params[:title], description: params[:description], price: params[:price].to_i)
    	@item.update_attributes(image: params[:image]) unless params[:image].blank?
    	feature_titles = params[:feature_titles]
    	feature_titles.each_key do |id|
	      begin
		    	if feature = Feature.find(id)
		        feature.update_attributes(title: feature_titles[id])
		      end
	      rescue ActiveRecord::RecordNotFound
	        unless feature_titles[id].blank?
	        	Feature.create(title: feature_titles[id], item_id: @item.id)
	    	  end
	      end  	
      end
    else
      flash[:danger] = "Ошибка! Проверьте заполнены ли все поля"
    end
    respond_to do |format|
        format.js
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    @items = Item.all
    respond_to do |format|
      format.js
    end
  end


  def preorder_create
    @item = Item.create(title: params[:title],description: params[:description], image: params[:image], preorder: true)
    if @item.save
    	feature_titles = params[:feature_titles]
    	feature_values = params[:feature_values]
      for i in 0..3
        if feature_titles[i.to_s].blank? or feature_values[i.to_s].blank?
        	break
        else 
          Feature.create(item_id: @item.id, title: feature_titles[i.to_s], value: feature_values[i.to_s] )        
        end
      end
    else
      flash[:danger] = "Ошибка! Проверьте заполнены ли все поля"
    end
    respond_to do |format|
        format.js
    end
  end

  def preorder_update
    @item = Item.find(params[:id])
    @items = Item.all
    if @item.update_attributes(title: params[:title], description: params[:description])
    	@item.update_attributes(image: params[:image]) unless params[:image].blank?
    	feature_titles = params[:feature_titles]
    	feature_values = params[:feature_values]
    	feature_titles.each_key do |id|
	      begin
		    	if feature = Feature.find(id)
		        feature.update_attributes(title: feature_titles[id], value: feature_values[id])
		      end
	      rescue ActiveRecord::RecordNotFound
	        unless feature_titles[id].blank? or feature_values[id].blank?
	        	Feature.create(title: feature_titles[id],value: feature_values[id], item_id: @item.id)
	    	  end
	      end  	
    	end
      flash[:success] = "Предзаказ обновлён"
    else
      flash[:danger] = "Ошибка! Проверьте заполнены ли все поля"
    end
    respond_to do |format|
        format.js
    end
  end

  def order_new
  	@item = Item.find(params[:id])
    @items = Item.where(show: true)
  	respond_to do |format|
        format.js
    end
  end

  def order_create
    @item = Item.find(params[:id])
    unless params[:name].blank? or params[:email].blank? or params[:phone].blank? or params[:adress].blank? or params[:city].blank? or params[:index].blank?
      Mailer.ItemOrder(params[:name],params[:email],params[:phone],params[:payment],params[:id],params[:adress],params[:index],params[:city],params[:comment]).deliver
      @payment = params[:payment]
      @deliver = 1
    else
      flash[:danger] = "Все поля должны быть заполнены"
      @deliver = 0
    end
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

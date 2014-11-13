class SubscribersController < ApplicationController
	include ApplicationHelper
	before_action :admin_user, only: [:subscribe]

	def create
		@subscriber = Subscriber.new(subscriber_params)
		if @subscriber.save
      Mailer.Subscriber_create_mail(@subscriber.email).deliver
      flash[:success] = "Вы оформили подписку на наши новости"
    else
      flash[:danger] = "Ошибка! Подписка не оформлена"
    end
		@new_subscriber = Subscriber.new
		respond_to do |format|
			format.js
		end
	end
  
  def destroy
  	@subscriber = Subscriber.find(params[:id])
  	@subscribers = Subscriber.all
  	@subscriber.destroy
  	respond_to do |format|
  		format.js
  	end
  end

  def unsubscribe
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy
  end

  def subscribe
    @subscribers = Subscriber.all
    @subscribers.each do |s|
    	Mailer.Subscribe(s.name,s.email,params[:text].html_safe,params[:subject]).deliver
    end
    flash[:success] = "Сообщение отправлено"
    respond_to do |format|
    	format.js
    end
  end

  private

    def subscriber_params
      params.require(:subscriber).permit(:name, :email, :phone)
    end

    def admin_user
      unless is_admin?
        raise ActionController::RoutingError.new('Not Found')
      end
    end
end

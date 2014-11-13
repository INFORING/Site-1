class PagesController < ApplicationController
	before_action :admin_user, only: [:admin_panel,:update_options]
  include ApplicationHelper

  def home
    @items = Item.where(show: true).order('priority')
    @offer = Offer.find_by(position: 2)
    @offers = Offer.where(position: 1)
    @preorder = Item.find_by(preorder: true)
    @faq = Faq.where(show:true)
    @reviews = Review.where(show:true)
    @new_review = Review.new
    @new_subscriber = Subscriber.new
    @contacts = {}
    @contacts[:adress] = Feature.create(title: "adress", value:"Адрес") unless @contacts[:adress] = Feature.find_by(title: "adress")
    @contacts[:phone] = Feature.create(title: "phone", value:"Телефон") unless @contacts[:phone] = Feature.find_by(title: "phone")
    @contacts[:email] = Feature.create(title: "email", value:"Почта") unless @contacts[:email] = Feature.find_by(title: "email")
    @contacts[:info] = Feature.create(title: "info", value:"Информация") unless @contacts[:info] = Feature.find_by(title: "info")
    @contacts[:phone2] = Feature.create(title: "phone2", value:" ") unless @contacts[:phone2] = Feature.find_by(title: "phone2")
    @contacts[:phone3] = Feature.create(title: "phone3", value:" ") unless @contacts[:phone3] = Feature.find_by(title: "phone3")
    @contacts[:about] = Feature.create(title: "about", value:" ") unless @contacts[:about] = Feature.find_by(title: "about")
    @contacts[:contact] = Feature.create(title: "contact", value:" ") unless @contacts[:contact] = Feature.find_by(title: "contact")
  end

  def admin_panel
    @items = Item.all
    @offers = Offer.all
    @preorder = Item.find_by(preorder: true)
    @faqs = Faq.all
    @reviews = Review.all
    @subscribers = Subscriber.all
    @adress = Feature.find_by(title: "adress").value
    @phone = Feature.find_by(title: "phone").value
    @email = Feature.find_by(title: "email").value
    @info = Feature.find_by(title: "info").value
    @phone2 = Feature.find_by(title: "phone2").value
    @phone3 = Feature.find_by(title: "phone3").value
    @about = Feature.find_by(title: "about").value
    @contact = Feature.find_by(title: "contact").value
  end

  def admin_signin
    redirect_to admin_panel_path if is_admin?
  end

  def admin_session_destroy
    cookies.delete :remember_token
    redirect_to root_url 
  end

  def admin_session_create
    if (password = Feature.find_by(title: "password")).nil?
      password = Feature.create(title: "password",value: Digest::SHA1.hexdigest("Ogurec2000"))
    end
    if Digest::SHA1.hexdigest(params[:password].to_s) == password.value
      remember_token = SecureRandom.urlsafe_base64
      cookies.permanent[:remember_token] = remember_token
      if token = Feature.find_by(title: "remember_token")
        token.update_attributes(value: Digest::SHA1.hexdigest(remember_token.to_s))
      else
        Feature.create(title: "remember_token", value: Digest::SHA1.hexdigest(remember_token.to_s))
      end
      redirect_to admin_panel_path
    else
      redirect_to admin_signin_path
    end
  end

  def feedback
    unless params[:name].blank? or params[:email].blank? or params[:phone].blank? or params[:text].blank?
      Mailer.Feedback(params[:name],params[:email],params[:phone],params[:text].html_safe).deliver
      flash[:success] = "Ваше сообщение отправлено"
    else
      flash[:danger] = "Ошибка! Ваше сообщение не отправлено"
    end
    respond_to do |format|
        format.js
    end
  end

  def update_password 
    unless params[:password].blank? or params[:password_confirmation].blank? or params[:password] != params[:password_confirmation]
      Feature.find_by(title: "password").update_attributes(value: Digest::SHA1.hexdigest(params[:password].to_s))
    end
    respond_to do |format|
      format.js
    end
    @adress = Feature.find_by(title: "adress").value
    @phone = Feature.find_by(title: "phone").value
    @email = Feature.find_by(title: "email").value
    @info = Feature.find_by(title: "info").value
    @phone2 = Feature.find_by(title: "phone2").value
    @phone3 = Feature.find_by(title: "phone3").value
    @about = Feature.find_by(title: "about").value
    @contact = Feature.find_by(title: "contact").value
  end

  def update_options
    unless params[:email].blank? or params[:adress].blank? or params[:phone].blank? 
      Feature.find_by(title: "email").update_attributes(value: params[:email])
      Feature.find_by(title: "phone").update_attributes(value: params[:phone])
      Feature.find_by(title: "adress").update_attributes(value: params[:adress])
      Feature.find_by(title: "info").update_attributes(value: params[:info])
      Feature.find_by(title: "phone2").update_attributes(value: params[:phone2])
      Feature.find_by(title: "phone3").update_attributes(value: params[:phone3])
      Feature.find_by(title: "about").update_attributes(value: params[:about])
      Feature.find_by(title: "contact").update_attributes(value: params[:contact])
    end
    @adress = Feature.find_by(title: "adress").value
    @phone = Feature.find_by(title: "phone").value
    @email = Feature.find_by(title: "email").value
    @info = Feature.find_by(title: "info").value
    @phone2 = Feature.find_by(title: "phone2").value
    @phone3 = Feature.find_by(title: "phone3").value
    @about = Feature.find_by(title: "about").value
    @contact = Feature.find_by(title: "contact").value
    respond_to do |format|
      format.js
    end
  end

  def show_picture
    @image_url = params[:image]
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

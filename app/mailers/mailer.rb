class Mailer < ActionMailer::Base
  def Subscribe(name,email,text,subject)
  	@name = name
  	@text = text
  	mail(to: email, subject: subject)
  end

  def ItemOrder(name,email,phone,payment,id,adress,index,city)
  	@name = name
  	@phone = phone
  	@item = Item.find(id)
  	@email = email
  	@payment = payment
    @adress = adress
    @index = index
    @city = city
  	if @item.preorder?
  		mail(to: "order@royz-techmag.ru", subject: "Предзаказ #{@item.title}")
  	else  
  	  mail(to: "order@royz-techmag.ru", subject: "Заказ #{@item.title}")
    end
  end

  def OfferOrder(name,email,phone,payment,id,adress,index,city)
    @name = name
    @phone = phone
    @offer = Offer.find(id)
    @email = email
    @payment = payment
    @adress = adress
    @index = index
    @city = city 
    xmail(to: "order@royz-techmag.ru", subject: "Заказ на акцию #{@offer.title}")
  end

  def Feedback(name,email,phone,text)
  	@name = name
  	@phone = phone
  	@email = email
  	@text = text
  	mail(to: "feedback@royz-techmag.ru", subject: "Обратная связь")
  end

  def Subscriber_create_mail(email)
    @subscriber = Subscriber.find_by(email: email)
    @email = email
    mail(to: email, subject: "Подписка на сайт royz-techmag.ru")
  end
end

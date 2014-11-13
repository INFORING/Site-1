module ApplicationHelper
  def to_boolean(str)
     str == "true" or str == "1"
  end

  def count_tag(count)
    if count == 0
      "item active"
    else
      "item" 
    end
  end

  def faq_href_tag(count)
    "#faq#{count}"
  end

  def faq_tag(count)
    "faq#{count}"
  end

  def is_admin?
    remember_token = Feature.find_by(title: "remember_token")
    unless cookies[:remember_token].nil?
      true if Digest::SHA1.hexdigest(cookies[:remember_token]) == remember_token.value and !remember_token.nil?
    else
      false
    end
  end

  def bootstrap_class_for flash_type
    "alert-#{flash_type.to_s}"
  end
end

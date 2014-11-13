class Review < ActiveRecord::Base
	validates :text,  presence: true
	validates :name,  presence: true, on: :create
	validates :email,  presence: true, on: :create

  has_attached_file :image, :styles => { :large => "600x600!", :medium => "300x300!", :thumb => "100x100!" }, :default_url => "user-icon.jpg"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

end

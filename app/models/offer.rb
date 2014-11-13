class Offer < ActiveRecord::Base
 validates :title,  presence: true
 validates :description,  presence: true
 validates :end_at, presence: true
 validates :new_price, presence: true
 validates :old_price, presence: true
 validates :old_price, presence: true

 has_many :features, dependent: :destroy

 has_attached_file :image, :styles => { :large => "600x600!", :medium => "300x300!", :thumb => "100x100!" }
 validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
end

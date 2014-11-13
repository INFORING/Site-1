class Feature < ActiveRecord::Base
  validates :title,  presence: true

  belongs_to :item
  belongs_to :offer
  belongs_to :preorder
end

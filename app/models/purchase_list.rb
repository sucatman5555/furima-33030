class PurchaseList < ApplicationRecord
  # Association
  belongs_to :user
  belongs_to :item
  has_one :address
  # //Association
end

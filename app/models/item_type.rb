class ItemType < ActiveRecord::Base
    belongs_to :product_type
	belongs_to :product
end

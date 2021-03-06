class FoodType < ActiveRecord::Base
    has_many :dish_types
	has_many :ecommers, :through => :dish_types
	has_many :suppliers, :through => :dish_types
	
	has_attached_file :icon, styles: { large: "300x300>", medium: "120x120>", square: "30x30>", thumb: "16x16>" }, default_url: "/images/:style/logo-placeholder.png"
    validates_attachment_content_type :icon, content_type: /\Aimage\/.*\Z/
end

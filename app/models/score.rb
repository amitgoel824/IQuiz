class Score < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	attr_accessible :user_id,:category_id,:score
end

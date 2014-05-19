class Question < ActiveRecord::Base
	belongs_to :category
	attr_accessible :statement,:option1,:option2,:option3,:option4,:answer,:stars,:category_id
end

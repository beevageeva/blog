class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  attr_accessible :content, :description, :title, :category_id
	has_many :comments, :dependent => :destroy

end

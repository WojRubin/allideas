class Category < ActiveRecord::Base
  acts_as_nested_set
  has_many :products, :dependent => :destroy
  validates :name, presence: true

  serialize :category_details

  def self.siblings parent
  	 siblings = self.where("lft > ? AND rgt < ? AND depth = ?", parent.lft, parent.rgt, (parent.depth + 1))
  	 return siblings
  end
end
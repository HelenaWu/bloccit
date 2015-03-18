class Topic < ActiveRecord::Base
  include Paginate
  has_many :posts
  validates :name, length: {minimum: 5}

  # def self.im_a_class_method
  # end
end

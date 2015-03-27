class Topic < ActiveRecord::Base
  # include Paginate
  has_many :posts, dependent: :destroy
  validates :name, length: {minimum: 5}

  scope :visible_to, -> (user){user ? all : where(public: true)}
  # def self.im_a_class_method
  # end
end

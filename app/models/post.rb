class Post < ActiveRecord::Base
  # include Paginate
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  has_many :votes, dependent: :destroy

  # default_scope {order('created_at DESC')}
  default_scope {order('rank DESC')}

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  # validates :topic, presence: true
  # validates :user, presence: true
  after_create :create_vote

  def up_votes
    votes.where(value: 1).count
  end
  def down_votes
    votes.where(value: -1).count
  end
  def points
    up = self.up_votes
    down = -self.down_votes
    up + down
  end
  
  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1))/(60*60*24)
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end


  private
  def create_vote
    user.votes.create(value: 1, post: self, user: user)
  end
end

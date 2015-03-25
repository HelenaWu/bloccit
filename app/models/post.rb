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
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count
  end
  def down_votes
    votes.where(value: -1).count
  end
  def points
    votes.sum(:value)
  end
  
  def update_rank
    age_in_days = (self.created_at - Time.new(1970,1,1))/(60*60*24)
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end


  def create_vote
    #for some reason user.votes.create(..) does work here, so adding user in param field
    # (error: parent not saved)?
    votes.create(value: 1, post: self, user: user)
  end

  def save_with_initial_vote
    result = false
    ActiveRecord::Base.transaction do
      #why do we need to check for self.valid? here but not when it was in posts_controller?
      result = (self.save && self.valid?)
      self.create_vote
    end   

    return result
  end
end

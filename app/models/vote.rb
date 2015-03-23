class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :value, inclusion: {in: [-1,1], message: "%{value} is not a valid vote."}
  after_save :update_post

  private 
  def update_post
    #Just confirming, can't update_post if post hasn't been created right?
    if (post.created_at)
      post.update_rank
    end
  end
end

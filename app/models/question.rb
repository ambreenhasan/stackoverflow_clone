class Question < ActiveRecord::Base
  has_many :answers
  validates :title, presence: true

  def upvote(vote_count)
    self.vote_count += 1
  end

  def downvote(vote_count)
    self.vote_count -= 1
  end
end

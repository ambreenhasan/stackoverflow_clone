class Answer < ActiveRecord::Base
  belongs_to :question

  def upvote(vote_count)
    self.vote_count += 1
  end

  def downvote(vote_count)
    self.vote_count -= 1
  end
end

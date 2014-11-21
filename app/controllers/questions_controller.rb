class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def edit
     @question = Question.find(params[:question_id])
  end

  def update
    @question = Question.find(params[:question_id])

    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @question.destroy

    redirect_to questions_path
  end

  def upvote
    @question = Question.find(params[:id])

    @question.upvote(@question.vote_count)

    if @question.save
      redirect_to questions_path
    end
  end

  def downvote
    @question = Question.find(params[:id])

    @question.downvote(@question.vote_count)

    if @question.save
      redirect_to questions_path
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :text, :vote_count)
  end
end

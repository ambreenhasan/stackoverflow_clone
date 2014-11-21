class AnswersController < ApplicationController
  def index
    @answers = Answer.all
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = @question.answers
  end

  def new
    @answer = Answer.new
  end

  def create
     @question = Question.find(params[:question_id])
     @answer = @question.answers.create(answer_params)

     respond_to do |format|
       if @answer.save
        format.html {redirect_to question_path(@question)}
        format.js {render :create }
       else
        format.html {redirect_to question_path(@question)}
        format.js {render :error }
       end
     end
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find([:id])
    Answer.where(question_id: params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find([:id])

    if @answer.update(answer_params)
      redirect_to question_path(@question)
    else
      render 'edit'
    end
  end


  def upvote
    p params
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])

    @answer.upvote(@answer.vote_count)

    if @answer.save
      redirect_to question_path(@question)
    end
  end

   def downvote
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])

    @answer.downvote(@answer.vote_count)

    if @answer.save
      redirect_to question_path(@question)
    end
  end


  def delete
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find([:id])
    @answer.destroy

    redirect_to question_path(@question)
  end

  private
  def answer_params
    params.require(:answer).permit(:text)
  end
end

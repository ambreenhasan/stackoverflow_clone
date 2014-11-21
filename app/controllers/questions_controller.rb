class QuestionsController < ApplicationController
  def index
    @question = Question.new
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @questions = Question.all
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html {redirect_to root_path, notice: "Question successfully created"}
        format.js {render :create}
      else
        format.html {redirect_to root_path}
        format.js {render :error }
      end
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

    respond_to do |format|
      if @question.save
        format.html {redirect_to root_path, notice: "Question successfully created"}
        format.js {render :upvote}
      else
        format.html {redirect_to root_path}
        format.js {render :error }
      end
    end
  end

  def downvote
    @question = Question.find(params[:id])

    @question.downvote(@question.vote_count)

    respond_to do |format|
      if @question.save
        format.html {redirect_to root_path, notice: "Question successfully created"}
        format.js {render :downvote}
      else
        format.html {redirect_to root_path}
        format.js {render :error }
      end
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :text, :vote_count)
  end
end

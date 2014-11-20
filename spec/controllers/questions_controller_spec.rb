require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  describe "Questions" do
    it "#index responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "#index renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "#index loads all of the questions into @questions" do
      question1, question2 = FactoryGirl.create(:question),FactoryGirl.create(:question)
      get :index

      expect(assigns(:questions)).to match_array([question1, question2])
    end

    it "#show finds a question by id" do
      question = FactoryGirl.create(:question)
      get :show, id: question.id


      expect(assigns(:question)).to match(question)
    end

    it "assigns a new question to @question" do
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "creates a post" do
      expect {
        post :create, :question => FactoryGirl.attributes_for(:question)
        expect(response).to be_redirect
      }.to change { Question.count }.by(1)
    end

    it "does not save a post with invalid params" do
      expect {
        post :create, :question => { :title => ""}
        expect(response).to_not be_redirect
      }.to_not change { Question.count }
    end

    it "#edit finds a question by id" do
      question = FactoryGirl.create(:question)
      get :edit, id: question.id

      expect(assigns(:question)).to match(question)
    end

    it "#update loads @question" do
      question = FactoryGirl.create(:question)
      patch :update, id: question.id, question: {title:"hello"}

      expect(assigns(:question)).to eq(question)
    end

    it "failing update renders edit template" do
      question = FactoryGirl.create(:question)
      patch :update, id: question.id, question: {title:""}
      expect(response).to render_template("edit")
    end

    it "#delete finds and loads @question" do
      question = FactoryGirl.create(:question)
      delete :destroy, id: question.id, question: FactoryGirl.attributes_for(:question)
      expect(assigns(:question)).to eq(question)
    end

    it "#delete deletes a question" do
       question = FactoryGirl.create(:question)
      delete :destroy, id: question.id, question: FactoryGirl.attributes_for(:question)

      expect(response).to be_redirect
    end

  end
end

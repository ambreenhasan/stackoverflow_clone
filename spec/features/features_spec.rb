describe "Questions" do
  let!(:question) {create :question}
  let!(:questions) {[question, create(:question)]}
  describe "A guest can see all questions" do
    it "by visiting the homepage" do
      visit root_path
       questions.each do |t|
        expect(page).to have_content t.title
      end
    end
  end

  describe "A guest can visit a todo list page" do
    it "by clicking on a question title link on homepage" do
      visit root_path
      click_link('How do I add a form?')
      expect(page).to have_content "How do I add a form?"
    end
  end
end
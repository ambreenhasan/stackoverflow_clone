class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text
      t.integer :question_id
      t.integer :vote_count, default: 0

      t.timestamps
    end
  end
end

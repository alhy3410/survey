class AddColumnAnswerToQuestionsTable < ActiveRecord::Migration
  def change
    add_column(:questions, :answer, :string)
  end
end

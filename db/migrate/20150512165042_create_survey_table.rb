class CreateSurveyTable < ActiveRecord::Migration
  def change
    create_table(:surveys) do |t|
      t.column(:survey_name, :string)
    end
  end
end

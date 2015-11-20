class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references  :survey
      t.string      :text, null: false

      t.timestamps
    end
  end
end

class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references  :user, null: false
      t.string  :title, null: false
      t.string  :description, null: false

      t.timestamps
    end
  end
end
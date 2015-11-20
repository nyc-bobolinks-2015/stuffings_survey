class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.references  :question, null: false
      t.string      :text, null: false

      t.timestamps
    end
  end
end

class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :statement
      t.string :option1
      t.string :option2
      t.string :option3
      t.string :option4
      t.integer :answer
      t.integer :stars
      t.integer :category_id

      t.timestamps
    end
  end
end

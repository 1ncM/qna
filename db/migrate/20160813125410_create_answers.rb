class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :owner
      t.text :email

      t.timestamps
    end
  end
end

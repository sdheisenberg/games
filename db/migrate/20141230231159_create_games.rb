class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :console
      t.integer :year
      t.text :description

      t.timestamps null: false
    end
  end
end

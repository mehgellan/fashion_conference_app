class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :topic
      t.integer :duration

      t.timestamps null: false
    end
  end
end

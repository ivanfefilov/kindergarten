class CreateGameItems < ActiveRecord::Migration[5.0]
  def change
    create_table :game_items do |t|
      t.string :title
      t.boolean :eatable
      t.timestamps
    end
  end
end

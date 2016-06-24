class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.integer :parent_id, null: false
      t.string :parent_type, null: false
      t.string :file, null: false
      t.string :file_name
      t.integer :file_size
      t.string :file_type

      t.timestamps
    end
  end
end

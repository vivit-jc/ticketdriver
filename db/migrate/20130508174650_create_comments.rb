class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.references :ticket
      t.string :comment
      t.timestamps
    end
    add_index :comments, :ticket_id
  end
end

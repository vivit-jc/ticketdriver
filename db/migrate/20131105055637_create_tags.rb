class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.text :memo

      t.timestamps
    end
  end
end

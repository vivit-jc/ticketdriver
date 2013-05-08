class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.integer :status
      t.string :person
      t.integer :priority
      t.boolean :finished
      t.text :memo

      t.timestamps
    end
  end
end

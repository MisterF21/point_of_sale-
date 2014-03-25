class CreateCustomer < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.column :name, :string
      t.column :receipt, :string

      t.timestamps
    end
  end
end

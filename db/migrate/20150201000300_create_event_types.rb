class CreateRoleTypes < ActiveRecord::Migration
  def change
    create_table :role_types do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end

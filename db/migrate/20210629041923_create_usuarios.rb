class CreateUsuarios < ActiveRecord::Migration[6.1]
  def change
    create_table :usuarios do |t|
      t.string :nome, limit: 50, null: false
      t.integer :perfil, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps  null: false
    end
  end
end

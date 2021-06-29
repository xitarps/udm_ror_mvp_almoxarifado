class CreateEntradas < ActiveRecord::Migration[6.1]
  def change
    create_table :entradas do |t|
      t.date :data, null: false
      t.string :documento, limit: 10, null: false
      t.string :numero, limit: 10, null: false
      t.decimal :quantidade, default: 0, null: false, :precision => 11, :scale => 4
      t.decimal :preco_unitario, default: 0, null: false, :precision => 11, :scale => 2
      t.decimal :preco_total, default: 0, null: false, :precision => 11, :scale => 2
      t.text :observacoes, limit: 80, null: true
      t.references :estoque, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end

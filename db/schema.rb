# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_29_062730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entradas", force: :cascade do |t|
    t.date "data", null: false
    t.string "documento", limit: 10, null: false
    t.string "numero", limit: 10, null: false
    t.decimal "quantidade", precision: 11, scale: 4, default: "0.0", null: false
    t.decimal "preco_unitario", precision: 11, scale: 2, default: "0.0", null: false
    t.decimal "preco_total", precision: 11, scale: 2, default: "0.0", null: false
    t.text "observacoes"
    t.bigint "estoque_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["estoque_id"], name: "index_entradas_on_estoque_id"
  end

  create_table "estoques", force: :cascade do |t|
    t.integer "tipo", default: 0, null: false
    t.string "descricao", limit: 50, null: false
    t.string "codigo", limit: 30
    t.string "unidade", limit: 5, null: false
    t.boolean "perecivel", default: false
    t.decimal "estoque_minimo", precision: 11, scale: 4, default: "0.0", null: false
    t.decimal "estoque_maximo", precision: 11, scale: 4, default: "0.0", null: false
    t.decimal "estoque_reposicao", precision: 11, scale: 4, default: "0.0", null: false
    t.decimal "estoque_saldo", precision: 11, scale: 4, default: "0.0", null: false
    t.decimal "custo_medio", precision: 11, scale: 2, default: "0.0", null: false
    t.decimal "custo_total", precision: 11, scale: 2, default: "0.0", null: false
    t.string "conta_contabil", limit: 30
    t.string "localizacao", limit: 30
    t.integer "status", default: 0, null: false
    t.bigint "grupo_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grupo_id"], name: "index_estoques_on_grupo_id"
  end

  create_table "grupos", force: :cascade do |t|
    t.string "nome", limit: 30, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "requisicoes", force: :cascade do |t|
    t.integer "tipo", default: 0, null: false
    t.date "data", null: false
    t.string "numero", limit: 10, null: false
    t.integer "setor", default: 0, null: false
    t.decimal "quantidade", precision: 11, scale: 4, default: "0.0", null: false
    t.decimal "custo_medio", precision: 11, scale: 2, default: "0.0", null: false
    t.decimal "custo_total", precision: 11, scale: 2, default: "0.0", null: false
    t.text "observacoes"
    t.bigint "estoque_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["estoque_id"], name: "index_requisicoes_on_estoque_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome", limit: 50, null: false
    t.integer "perfil", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  add_foreign_key "entradas", "estoques"
  add_foreign_key "estoques", "grupos"
  add_foreign_key "requisicoes", "estoques"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_19_055329) do

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "votes", default: 0
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "code"
    t.string "product_name"
    t.text "description"
    t.text "long_descr"
    t.text "custom_col"
    t.integer "gpo_uk", default: 0
    t.integer "gpo_euro", default: 0
    t.integer "gpo_au", default: 0
    t.integer "gpo_china", default: 0
    t.integer "tuf", default: 0
    t.integer "tuf_r", default: 0
    t.integer "watts", default: 0
    t.float "lead_m", default: 0.0
    t.integer "hdmi_f", default: 0
    t.integer "hdmi_cut", default: 0
    t.integer "hdmi_coupler", default: 0
    t.integer "data_cut", default: 0
    t.integer "data_f", default: 0
    t.integer "data_coupler", default: 0
    t.boolean "three_pin_to", default: false
    t.boolean "three_pin", default: false
    t.boolean "j_coupler", default: false
    t.boolean "red", default: false
    t.boolean "white", default: false
    t.boolean "black", default: false
    t.boolean "grey", default: false
    t.boolean "silver_ano", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "posts", "users"
end

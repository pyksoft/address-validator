# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171016162817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "histories", force: :cascade do |t|
    t.string "country"
    t.string "shipping_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.boolean "auto_complete", default: true
    t.boolean "validate_address", default: true
    t.boolean "pobox_warning", default: false
    t.boolean "streetnum_warning", default: false
    t.string "store_domain"
    t.string "color_background", default: "dff0d8"
    t.string "color_border", default: "d0e9c6"
    t.string "color_text", default: "3c763d"
    t.string "color_highlight", default: "2C5DFF"
    t.string "color_hover", default: "FFF4BB"
    t.string "text_apt_suite", default: "Did you specify the correct apt/suite/unit?"
    t.string "text_inaccurate", default: "Is the shipping address correct?"
    t.string "text_select_confirm", default: "Thanks for confirming your shipping address!"
    t.string "text_select_suggestion", default: "Your shipping address has been updated!"
    t.string "text_suggest1", default: "Please select shipping address"
    t.string "text_suggest2", default: "To ensure prompt and accurate delivery, we suggest a modified shipping address."
    t.string "text_correct", default: "Thanks for specifying an accurate shipping address!"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "text_pobox_warning", default: "We cannot deliver to a P.O. Box. Please provide a valid street address."
    t.text "text_streetnum_warning", default: "Please specify a street number."
    t.string "color_background_warning", default: "fcf8e3"
    t.string "color_border_warning", default: "faf2cc"
    t.string "color_text_warning", default: "8a6d3b"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

end

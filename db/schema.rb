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

ActiveRecord::Schema.define(version: 2019_12_21_083428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "external_http_request_logs", force: :cascade do |t|
    t.text "kind", null: false
    t.jsonb "meta"
    t.text "response_body", null: false
    t.integer "response_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "link_clicks", force: :cascade do |t|
    t.bigint "link_id", null: false
    t.string "host", null: false
    t.text "user_agent", null: false
    t.text "referer"
    t.string "anonymized_ip", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "device_family"
    t.string "device_model"
    t.string "device_brand"
    t.string "os_family"
    t.string "os_version"
    t.string "user_agent_family"
    t.string "user_agent_version"
    t.index ["link_id"], name: "index_link_clicks_on_link_id"
  end

  create_table "links", force: :cascade do |t|
    t.text "url", null: false
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["slug"], name: "index_links_on_slug", unique: true
  end

  add_foreign_key "link_clicks", "links"
end

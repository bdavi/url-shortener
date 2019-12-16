# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_191_216_033_618) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'external_http_request_logs', force: :cascade do |t|
    t.text 'kind', null: false
    t.jsonb 'meta'
    t.text 'response_body', null: false
    t.integer 'response_code', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'links', force: :cascade do |t|
    t.text 'url', null: false
    t.string 'slug', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'status', default: 0
    t.index ['slug'], name: 'index_links_on_slug', unique: true
  end
end

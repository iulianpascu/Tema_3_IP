# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130506164903) do

  create_table "asocieri", :force => true do |t|
    t.integer "curs_id"
    t.integer "grupa_id"
    t.integer "an"
    t.integer "semestru"
  end

  create_table "cursuri", :force => true do |t|
    t.string  "nume"
    t.string  "tip"
    t.integer "profesor_id"
  end

  create_table "data_evaluari", :force => true do |t|
    t.boolean "grupa_terminal"
    t.date    "data"
  end

  create_table "eval_completate", :force => true do |t|
    t.integer "curs_id"
    t.string  "incognito_user_token"
    t.integer "timp"
    t.hstore  "continut"
    t.date    "data"
  end

  add_index "eval_completate", ["continut"], :name => "eval_comp_continut"

  create_table "formulare", :force => true do |t|
    t.text    "continut"
    t.integer "an"
    t.integer "semestru"
    t.string  "stadiu"
    t.string  "specializare"
    t.string  "tip_curs",     :limit => 1, :default => "c"
  end

  create_table "grupe", :force => true do |t|
    t.integer "nume"
    t.integer "studenti"
    t.boolean "terminal"
    t.integer "an"
    t.integer "serie"
    t.string  "specializare"
    t.integer "formular_id"
    t.string  "domeniu"
  end

  add_index "grupe", ["nume"], :name => "idx_grupe_nume"

  create_table "incognito_users", :force => true do |t|
    t.string  "token"
    t.integer "grupa_nume"
  end

  add_index "incognito_users", ["token"], :name => "idx_token"

  create_table "profesori", :force => true do |t|
    t.string "nume"
    t.string "prenume"
    t.string "departament"
  end

  create_table "sesiune_active", :force => true do |t|
    t.string   "incognito_user_token"
    t.datetime "incepere_data"
  end

end

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

ActiveRecord::Schema.define(:version => 20130319200220) do

  create_table "curs", :force => true do |t|
    t.integer  "id_curs"
    t.string   "nume_curs"
    t.string   "tip_curs"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "data_evaluares", :force => true do |t|
    t.boolean  "an_terminal"
    t.datetime "data_start"
    t.datetime "data_stop"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "evaluare_finalizata", :force => true do |t|
    t.integer  "id_curs"
    t.integer  "id_prof"
    t.string   "token"
    t.string   "grupa"
    t.text     "detalii"
    t.integer  "durata"
    t.datetime "data_completare"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "evaluare_in_progres", :force => true do |t|
    t.string   "token"
    t.datetime "incepere_sesiune"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "evaluares", :force => true do |t|
    t.integer  "id_curs"
    t.integer  "id_prof"
    t.string   "grupa"
    t.boolean  "an_terminal"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "grupas", :force => true do |t|
    t.string   "grupa"
    t.integer  "studenti"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profesors", :force => true do |t|
    t.integer  "id_prof"
    t.string   "nume_prof"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "token"
    t.string   "grupa"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "token_digest"
    t.string   "cookie"
  end

  add_index "users", ["cookie"], :name => "index_users_on_cookie"
  add_index "users", ["token"], :name => "index_users_on_token", :unique => true

end

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

ActiveRecord::Schema.define(:version => 20130403211740) do

  create_table "cursuri", :force => true do |t|
    t.string  "nume"
    t.string  "tip"
    t.integer "profesor_id"
    t.integer "an"
  end

  create_table "data_evaluari", :force => true do |t|
    t.boolean "grupa_terminal"
    t.date    "data"
  end

  create_table "evaluare_completate", :force => true do |t|
    t.integer "evaluare_disponibila_id"
    t.string  "incognito_user_token"
    t.text    "continut"
    t.integer "timp"
  end

  create_table "evaluare_disponibile", :force => true do |t|
    t.integer "curs_id"
    t.integer "grupa_nume"
    t.integer "formular_id"
  end

  create_table "formulare", :force => true do |t|
    t.text "continut"
  end

  create_table "grupe", :force => true do |t|
    t.integer "nume"
    t.integer "studenti"
    t.boolean "terminal"
  end

  create_table "incognito_users", :force => true do |t|
    t.string  "token"
    t.integer "grupa_nume"
  end

  create_table "profesori", :force => true do |t|
    t.string "nume"
    t.string "prenume"
  end

  create_table "sesiune_active", :force => true do |t|
    t.string   "incognito_user_token"
    t.datetime "incepere_data"
  end

end

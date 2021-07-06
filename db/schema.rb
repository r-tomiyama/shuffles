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

ActiveRecord::Schema.define(version: 20_210_706_105_649) do
  create_table 'shuffle_items', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.string 'name', null: false
    t.bigint 'shuffle_list_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[shuffle_list_id name], name: 'index_shuffle_items_on_shuffle_list_id_and_name', unique: true
    t.index ['shuffle_list_id'], name: 'index_shuffle_items_on_shuffle_list_id'
  end

  create_table 'shuffle_lists', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.string 'name', null: false
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_shuffle_lists_on_user_id'
  end

  create_table 'users', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'shuffle_items', 'shuffle_lists'
  add_foreign_key 'shuffle_lists', 'users'
end

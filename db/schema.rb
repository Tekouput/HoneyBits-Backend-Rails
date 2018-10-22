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

ActiveRecord::Schema.define(version: 20180815184239) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_id"
    t.string   "zip_code"
    t.string   "primary_address"
    t.string   "secondary_address"
    t.string   "side_note"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "billings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "cart_id"
    t.decimal  "amount",                    precision: 10, scale: 6
    t.string   "user_id"
    t.float    "cut_percentage", limit: 24
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "cart_products_relation_ships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "cart_id"
    t.string   "product_id"
    t.string   "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "item_counts"
    t.string   "user_id"
    t.string   "address_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "carts_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_carts_products_on_cart_id", using: :btree
    t.index ["product_id"], name: "index_carts_products_on_product_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id", using: :btree
    t.index ["product_id"], name: "index_product_categories_on_product_id", using: :btree
  end

  create_table "follows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "follower_id"
    t.string   "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "product_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["product_id"], name: "index_product_images_on_product_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name"
    t.string   "description"
    t.decimal  "price",                  precision: 18, scale: 8
    t.float    "rating",      limit: 24
    t.integer  "shop_id"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_products_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.string   "profile_pic"
    t.float    "latitude",                  limit: 24
    t.float    "longitude",                 limit: 24
    t.text     "policy",                    limit: 65535
    t.float    "raiting",                   limit: 24
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "shop_picture_file_name"
    t.string   "shop_picture_content_type"
    t.integer  "shop_picture_file_size"
    t.datetime "shop_picture_updated_at"
    t.string   "user_id"
    t.integer  "rate_count"
    t.string   "shop_logo_file_name"
    t.string   "shop_logo_content_type"
    t.integer  "shop_logo_file_size"
    t.datetime "shop_logo_updated_at"
    t.string   "place_id"
    t.integer  "sales_count"
  end

  create_table "shops_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "shop_id", null: false
    t.index ["user_id", "shop_id"], name: "index_shops_users_on_user_id_and_shop_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "sex"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "phone_number"
    t.string   "stripe_id"
    t.integer  "bees"
    t.string   "role_id"
    t.string   "uuid"
    t.string   "provider"
    t.string   "profile_pic"
    t.string   "refresh_token"
    t.string   "user_picture_file_name"
    t.string   "user_picture_content_type"
    t.integer  "user_picture_file_size"
    t.datetime "user_picture_updated_at"
  end

  add_foreign_key "carts_products", "carts"
  add_foreign_key "carts_products", "products"
  add_foreign_key "product_images", "products"
  add_foreign_key "products", "users"
end

ActiveRecord::Schema.define(:version => 20110527184239) do

    create_table :sessions do |t|
    t.string :session_id, :null => false
    t.text :data
    t.timestamps
  end

  add_index :sessions, :session_id
  add_index :sessions, :updated_at

  create_table "linkrequests", :id => true, :force => true do |t|
    t.string   "organization_url"
    t.boolean  "is_active",                         :default => false
    t.string   "email"
    t.string   "record_text"
    t.string   "organization_name"
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.string   "first_name",         :limit => 15
    t.string   "mi",                 :limit => 1
    t.string   "last_name",          :limit => 15
    t.string   "city",               :limit => 15
    t.string   "country_id",             :limit => 4
    t.string   "providence",             :limit => 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state_id",             :limit => 4
    t.string   "zip_code",           :limit => 12
    t.boolean  "approved",                          :default => false
    t.string   "remote_ip",          :limit => 45
    t.integer  "img_height"
    t.integer  "img_width"
    t.string   "user_id",            :limit => 40,  :default => "",    :null => true


  end

  add_index "linkrequests", ["id"], :name => "uuid_index"

  create_table "offerings", :id => true, :force => true do |t|
    t.string   "linkrequest_id",       :limit => 40, :default => "0",   :null => false
    t.string   "resource_url", :null => true, :default => ""
    t.string   "resource_description", :default => ""
    t.boolean  "supporting",   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offerings", ["linkrequest_id"], :name => "uuid_index"

  create_table "perspectives", :id => false, :force => true do |t|
    t.string   "record_text"
    t.string   "email"
    t.string   "alias",      :limit => 16
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_ip"
    t.boolean  "approved",                 :default => false
    t.string   "user_id",    :limit => 40, :default => "0",   :null => true
    t.string   "p_uuid",       :limit => 40, :default => "0",   :null => false
  end

  add_index "perspectives", ["p_uuid"], :name => "uuid_index"

  create_table "comments", :id => false, :force => true do |t|
    t.string   "c_uuid", :limit => 40, :null => false
    t.string   "p_uuid", :limit => 40, :null => false
    t.string   "record_text"
    t.string   "email"
    t.string   "alias",      :limit => 16
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_ip"
    t.boolean  "approved",                 :default => false
  end

  add_index "comments", ["c_uuid"], :name => "uuid_index"

  create_table "signatures", :id => false, :force => true do |t|
    t.string   "uuid",               :limit => 40,  :default => "0",   :null => false
    t.string   "comments"
    t.string   "email",               :limit => 50
    t.string   "first_name",          :limit => 15
    t.string   "mi",                  :limit => 1
    t.string   "last_name",           :limit => 15
    t.string   "alias",               :limit => 16
    t.string   "address1",            :limit => 20
    t.string   "address2",            :limit => 20
    t.string   "state_id",             :limit => 4
    t.string   "postal_code",         :limit => 12
    t.string   "city",                :limit => 20
    t.string   "country_id",             :limit => 4
    t.string   "remote_ip"
    t.string   "providence",             :limit => 24
    t.boolean  "display_name",                      :default => false
    t.boolean  "signature_agreement",               :default => false
    t.datetime "created_at"
    t.datetime "update_at"
    t.boolean  "signature_number", :default => true
    t.boolean  "comments_approved"
    t.string   "YOB",                 :limit => 4
    t.string   "user_id",    :limit => 40, :default => "0",   :null => true
  end

  add_index "signatures", ["uuid"], :name => "uuid_index"


  create_table "users", :id => false, :force => true do |t|
    t.string   "user_id",               :limit => 40,  :default => "0",   :null => false
    t.string   "username",                  :limit => 40,  :default => "",         :null => false
    t.string   "email",                    :default => "",         :null => false
    t.string   "first_name",                :limit => 24,  :default => "",         :null => true
    t.string   "mi",                        :limit => 1,                           :null => true
    t.string   "last_name",                 :limit => 24,  :default => "",         :null => true
    t.string   "role",                      :limit => 8,   :default => "guest", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_ip"
    t.boolean  "approved",                                 :default => false
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.string   "reset_code",           :limit => 40
    t.datetime "activated_at"
  end
  add_index "users", ["user_id"], :name => "uuid_index"
end



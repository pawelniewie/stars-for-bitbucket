class CreateJwtUserInfo < ActiveRecord::Migration[5.0]
  def change
    create_table :jwt_user_infos do |t|
      t.integer :jwt_user_id, null: false
      t.string :email, null: false
    end

    add_foreign_key :jwt_user_infos, :jwt_users, on_delete: :cascade
  end
end

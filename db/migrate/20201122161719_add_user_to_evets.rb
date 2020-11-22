class AddUserToEvets < ActiveRecord::Migration[6.0]
  def change
    add_reference :evets, :user, null: false, foreign_key: true
  end
end

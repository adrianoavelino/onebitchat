class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :status
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end

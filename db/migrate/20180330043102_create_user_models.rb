class CreateUserModels < ActiveRecord::Migration[5.1]
  def change
    create_table :user_models do |t|

      t.timestamps
    end
  end
end

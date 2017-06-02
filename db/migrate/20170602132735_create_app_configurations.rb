class CreateAppConfigurations < ActiveRecord::Migration
  def change
    create_table :app_configurations do |t|
      t.text :configuration_json

      t.timestamps null: false
    end
  end
end

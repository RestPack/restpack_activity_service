class CreateActivityTable < ActiveRecord::Migration
  def table_name
    RestPack::Activity::Service.configuration.prefix_table_name(:activities)
  end

  def up
    create_table table_name do |t|
      t.integer :application_id
      t.integer :user_id
      t.string  :title
      t.text    :content
      t.text    :tag_list, :array => true, :default => []
      t.decimal :latitude, precision: 10, scale: 6, null: true
      t.decimal :longitude, precision: 10, scale: 6, null: true
      t.column  :search_vector, 'tsvector'
      t.json    :data
      t.timestamps
    end

    execute "CREATE INDEX #{table_name}_tag_list_index ON #{table_name} USING gin(tag_list)"
    execute "CREATE INDEX #{table_name}_search_index ON #{table_name} USING gin(search_vector)"
    execute "CREATE TRIGGER #{table_name}_vector_update BEFORE INSERT OR UPDATE
              ON #{table_name} FOR EACH ROW EXECUTE PROCEDURE
              tsvector_update_trigger(search_vector, 'pg_catalog.english', title, content);"
  end

  def down
    execute "DROP INDEX #{table_name}_tag_list_index"
    execute "DROP INDEX #{table_name}_search_index"
    drop_table table_name
  end
end

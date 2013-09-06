class CreateExtensionHstore < ActiveRecord::Migration
  def up
    execute "create extension hstore"
  end

  def down
    execute "drop extension hstore"
  end
end

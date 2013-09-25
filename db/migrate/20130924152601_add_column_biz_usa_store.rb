class AddColumnBizUsaStore < ActiveRecord::Migration
  def change
    add_column :profiles, :biz_usa_store, :json
  end
end

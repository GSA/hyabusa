class ChangeStoreTemporarilyFromJson < ActiveRecord::Migration
  def change
    change_column :profiles, :biz_usa_store, :text
  end
end

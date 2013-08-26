class AddBizProfileFields < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.column :annual_revenue, :integer
      t.column :annual_sales,   :integer

      t.column :org_type,       :string

      t.column :name,           :string
      t.column :address1,       :string
      t.column :address2,       :string
      t.column :city,           :string
      t.column :state,          :string
      t.column :postal_code,    :string
      t.column :country,        :string

      t.column :currently_exporting, :boolean

      t.column :naics_sector,   :integer
      t.column :naics_code,     :integer

      t.column :duns_no,        :integer
    end
  end
end

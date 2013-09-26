class AddMoreExportProfileFields < ActiveRecord::Migration
  def up
    add_column :profiles, :phone_number, :string
    add_column :profiles, :fax_number, :string
    add_column :profiles, :dunn_bradstreet, :string
    add_column :profiles, :website_url, :string
    remove_column :profiles, :annual_revenue
    rename_column :profiles, :annual_sales, :annual_export_sales
    add_column :profiles, :percent_export_sales, :string
    add_column :profiles, :export_status, :string
    add_column :profiles, :auth_export_gov_to_share, :boolean
    add_column :profiles, :auth_trade_promo_contact, :boolean
    add_column :profiles, :responsible_person_intl, :boolean
    add_column :profiles, :documented_product_sales_dist_auth, :boolean
    add_column :profiles, :export_type, :string
  end

  def down
    remove_column :profiles, :phone_number
    remove_column :profiles, :fax_number
    remove_column :profiles, :dunn_bradstreet, :duns_no
    remove_column :profiles, :website_url
    add_column :profiles, :annual_revenue, :integer
    rename_column :profiles, :annual_export_sales, :annual_sales
    remove_column :profiles, :percent_export_sales
    remove_column :profiles, :export_status
    remove_column :profiles, :auth_export_gov_to_share
    remove_column :profiles, :auth_trade_promo_contact
    remove_column :profiles, :responsible_person_intl
    remove_column :profiles, :documented_product_sales_dist_auth
    remove_column :profiles, :export_type
  end
end

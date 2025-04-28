# db/migrate/[timestamp]_add_contact_info_to_pages.rb
class AddContactInfoToPages < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :phone, :string
    add_column :pages, :email, :string
    add_column :pages, :address, :text
    add_column :pages, :contact_info, :text
    add_column :pages, :about_description1, :text
    add_column :pages, :about_description2, :text
  end
end
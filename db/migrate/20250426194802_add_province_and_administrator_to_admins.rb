class AddProvinceAndAdministratorToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_reference :admins, :province, foreign_key: true
    add_column :admins, :administrator, :boolean, default: false
  end
end
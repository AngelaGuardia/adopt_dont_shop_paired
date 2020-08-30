class RenameApplicationsToApplication < ActiveRecord::Migration[5.2]
  def change
    rename_column :pet_applications, :applications_id, :application_id
  end
end

class AddAttachmentIconToPlaceTypes < ActiveRecord::Migration
  def self.up
    change_table :place_types do |t|
      t.attachment :icon
    end
  end

  def self.down
    remove_attachment :place_types, :icon
  end
end

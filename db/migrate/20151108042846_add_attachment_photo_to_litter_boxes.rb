class AddAttachmentPhotoToLitterBoxes < ActiveRecord::Migration
  def self.up
    change_table :litter_boxes do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :litter_boxes, :photo
  end
end

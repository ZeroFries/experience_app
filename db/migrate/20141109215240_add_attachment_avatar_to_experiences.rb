class AddAttachmentAvatarToExperiences < ActiveRecord::Migration
  def self.up
    change_table :experiences do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :experiences, :avatar
  end
end

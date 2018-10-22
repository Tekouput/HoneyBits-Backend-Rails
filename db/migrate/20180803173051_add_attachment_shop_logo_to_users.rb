class AddAttachmentShopLogoToUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_table :shops do |t|
      t.attachment :shop_logo
    end
  end

  def self.down
    remove_attachment :shops, :shop_logo
  end
end

class Address < ApplicationRecord
  belongs_to :user

  def simple_info
    {
      zip_code: zip_code,
      primary_address: primary_address,
      secondary_address: secondary_address,
      side_note: side_note,
      latitude: latitude,
      longitude: longitude,
      map_id: map_id
    }
  end

end

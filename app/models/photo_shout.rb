class PhotoShout < ApplicationRecord
  has_one_attached :image

  def thumbnail
    return self.image.variant(resize: "200x200!").processed
  end

  def banner
    return self.image.variant(resize: "1200x300!").processed
  end
end

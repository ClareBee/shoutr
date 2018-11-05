class ShoutSearchQuery
  def initialize(term:, scope: Shout.all)
    @term = term
    @scope = scope
  end

  def to_relation
    matching_shouts_for_text_shouts.
    or(matching_shouts_for_photo_shouts)
  end

  private
  attr_reader :term, :scope

  def matching_shouts_for_text_shouts
    scope.where(content_type: "TextShout", content_id: matching_text_shouts.select(:id))
  end

  def matching_shouts_for_photo_shouts
    scope.where(content_type: "PhotoShout", content_id: matching_photo_shouts.select(:id))
  end

  def matching_text_shouts
    TextShout.where("body LIKE ?", "%#{term}%" )
  end

  def matching_photo_shouts
    results = ActiveStorage::Blob.where("filename LIKE ?", "%#{term}%")
    PhotoShout.where(id: results)
  end
end

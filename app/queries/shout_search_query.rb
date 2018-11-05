class ShoutSearchQuery
  def initialize(term:, scope: Shout.all)
    @term = term
    @scope = scope
  end

  def to_relation
    scope.
      joins("LEFT JOIN text_shouts ON content_type = 'TextShout' AND content_id = text_shouts.id").
      where("text_shouts.body LIKE ?", "%#{term}%")
  end

  private
  attr_reader :term, :scope
end

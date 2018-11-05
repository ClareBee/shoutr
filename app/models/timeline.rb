class Timeline
  def initialize(users)
    @users = users
  end

  def shouts
    Shout.
      where(user_id: users).
      order(created_at: :desc)
  end

  private
  attr_reader :user

end

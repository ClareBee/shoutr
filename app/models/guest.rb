class Guest < ApplicationRecord
  def email
    ""
  end

  def liked?(*args)
    return false
  end
end

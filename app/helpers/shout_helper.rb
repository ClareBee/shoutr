module ShoutHelper
  def like_button(shout)
    if current_user.liked?(shout)
      link_to "Unlike", unlike_shout_path(shout), method: :delete
    else
      link_to "Like", like_shout_path(shout), method: :post
    end
  end

  def autolink(text)
    text.gsub(/@\w+/) { |dm| link_to dm, user_path(dm[1..-1]) }.html_safe
  end

  def shout_form_for(shout_type)
    form_for Shout.new, url: shout_type.new do |f|
      f.hidden_field(:content_type, value: shout_type) +
      f.fields_for(:content) { |content_form| yield(content_form) } +
      f.submit('Shout!')
    end
  end
end

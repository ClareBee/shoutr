class HashtagsController < ApplicationController
  def show
    @hashtag = params[:id]
    @results = Shout.search(term: "##{@hashtag}")
  end
end

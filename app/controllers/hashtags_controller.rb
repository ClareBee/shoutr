class HashtagsController < ApplicationController
  def show
    @hashtag = params[:id]
    @results = ShoutSearchQuery.new(term: "##{@hashtag}").to_relation
  end
end

class Blog::TagsController < BlogController

  before_filter :find_all_blog_tags

  def show
    @tag = BlogTag.find(params[:id])
  end

  def index
    #respond_with (@tags) do |format|
    #  format.js
    #  format.html
    #  format.rss
    #end
  end

  def find_all_blog_tags
    @tags = BlogTag.all
  end

end

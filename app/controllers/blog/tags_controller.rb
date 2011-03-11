class Blog::TagsController < BlogController

  def show
    @tag = BlogTag.find(params[:id])
    @tags = BlogTag.all
  end

end

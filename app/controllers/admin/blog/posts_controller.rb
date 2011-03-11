class Admin::Blog::PostsController < Admin::BaseController

  crudify :blog_post,
          :title_attribute => :title,
          :order => 'published_at DESC'

  before_filter :find_all_categories,
                :only => [:new, :edit, :create, :update]

protected
  def find_all_categories
    @blog_categories = BlogCategory.find(:all)
    @blog_tags = BlogTag.find(:all)
  end
end

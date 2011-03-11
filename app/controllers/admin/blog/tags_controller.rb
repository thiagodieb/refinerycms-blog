class Admin::Blog::TagsController < Admin::BaseController

  crudify :blog_tag,
          :title_attribute => :title,
          :order => 'title ASC'

end

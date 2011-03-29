class Admin::Blog::PostsController < Admin::BaseController

  crudify :blog_post,
          :title_attribute => :title,
          :order => 'published_at DESC'
          
  def uncategorized
    @blog_posts = BlogPost.uncategorized.paginate({
      :page => params[:page],
      :per_page => BlogPost.per_page
    })
  end
  
  def create
    # if the position field exists, set this object as last object, given the conditions of this class.
    if BlogPost.column_names.include?("position")
      params[:blog_post].merge!({
        :position => ((BlogPost.maximum(:position, :conditions => "")||-1) + 1)
      })
    end
    
    if BlogPost.column_names.include?("user_id")
      params[:blog_post].merge!({
        :user_id => current_user.id
      })
    end

    if (@blog_post = BlogPost.create(params[:blog_post])).valid?
      (request.xhr? ? flash.now : flash).notice = t(
        'refinery.crudify.created',
        :what => "'#{@blog_post.title}'"
      )

      unless from_dialog?
        unless params[:continue_editing] =~ /true|on|1/
          redirect_back_or_default(admin_blog_posts_url)
        else
          unless request.xhr?
            redirect_to :back
          else
            render :partial => "/shared/message"
          end
        end
      else
        render :text => "<script>parent.window.location = '#{admin_blog_posts_url}';</script>"
      end
    else
      unless request.xhr?
        render :action => 'new'
      else
        render :partial => "/shared/admin/error_messages",
               :locals => {
                 :object => @blog_post,
                 :include_object_name => true
               }
      end
    end
  end

  before_filter :find_all_categories,
                :only => [:new, :edit, :create, :update]

protected
  def find_all_categories
    @blog_categories = BlogCategory.find(:all)
    @blog_tags = BlogTag.find(:all)
  end
end

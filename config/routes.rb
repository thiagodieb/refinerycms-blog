Refinery::Application.routes.draw do
  scope(:path => 'blog', :module => 'blog') do
    root :to => 'posts#index', :as => 'blog_root'
    match 'feed.rss', :to => 'posts#index.rss', :as => 'blog_rss_feed'
    match 'tags(.:format)', :to => 'tags#index', :as => 'blog_tags'
    match ':id', :to => 'posts#show', :as => 'blog_post'
    match 'categories/:id', :to => 'categories#show', :as => 'blog_category'
    match 'tags(.:format)', :to => 'tags#index', :as => 'blog_tags'
    match 'tags/:id', :to => 'tags#show', :as => 'blog_tag'
    match ':id/comments', :to => 'posts#comment', :as => 'blog_post_blog_comments'
    get 'archive/:year(/:month)', :to => 'posts#archive', :as => 'archive_blog_posts'
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    scope(:path => 'blog', :as => 'blog', :module => 'blog') do
      root :to => 'posts#index'
      resources :posts

      resources :categories

      resources :tags

      resources :comments do
        collection do
          get :approved
          get :rejected
        end
        member do
          get :approved
          get :rejected
        end
      end

      resources :settings do
        collection do
          get :notification_recipients
          post :notification_recipients

          get :moderation
        end
      end
    end
  end
end

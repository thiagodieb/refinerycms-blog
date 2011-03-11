class BlogTag < ActiveRecord::Base

  has_and_belongs_to_many :posts, :class_name => 'BlogPost'

  acts_as_indexed :fields => [:title]

  validates :title, :presence => true, :uniqueness => true

  has_friendly_id :title, :use_slug => true

  def post_count
    posts.select(&:live?).count
  end

  def self.build_cloud_map
    all_tags = self.all
    the_map = {}
    all_tags.each do |t|
      if the_map[t.post_count].nil?
        the_map[t.post_count] = []
      end
      the_map[t.post_count] << t
    end
    the_map
  end
end

module BlogTagsHelper
  def tag_cloud(html_element)
    the_map = BlogTag.build_cloud_map
    min = Float( the_map.keys.min )
    max = Float( the_map.keys.max )
    distribuition = 10
    html = ""
    BlogTag.build_cloud_map.each do |total, tag_list|
      size = ((distribuition * (total - min)) / (max - min)).ceil
      tag_list.each do |tag|
        html += "<#{html_element} class=\"cloud_size_#{size}\">#{tag.title}</#{html_element}>"
      end
    end
    html
  end
end

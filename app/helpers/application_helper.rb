module ApplicationHelper

  def linked_tags(list)
    list.map do |tag|
      link_to tag, group_path(tag)
    end.join(', ')
  end

end

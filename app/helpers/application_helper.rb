module ApplicationHelper

  def linked_tags(list)
    list.map do |tag|
      link_to tag, group_path(tag)
    end.join(', ')
  end

  def labeling_dyno_status(status)
    content_tag(:label, status, :class => "label #{status_mapping_label(status)}")
  end

  def status_mapping_label(status)
    {'up'       => 'label-success',
     'idle'     => 'label-warning',
     'starting' => 'label-warning',
     'crashed'  => 'label-important',
     'down'     => 'label-important',
     ''         => ''}[status]
  end

  def formatted_dynos(score)
    if score == 100
      "label-success"
    elsif score == 0
      "label-important"
    elsif score < 0
      ""
    else
      "label-warning"
    end
  end

end

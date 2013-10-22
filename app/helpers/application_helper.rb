module ApplicationHelper

  def linked_tags(list)
    Array(list).map do |tag|
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

  def dynos_status_css_class(score)
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

  def formatted_dynos_status_label(app)
    content_tag(:label, app.dynos_status_summary,
                class: "label #{dynos_status_css_class(app.dynos_status_score)}")
  end

end

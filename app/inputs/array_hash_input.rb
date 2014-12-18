class ArrayHashInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    input_html_options[:type] ||= input_type

    ary = Array(object.public_send(attribute_name))
    main = ary.map do |array_el|
      result = []
      array_el.each do |k, v|
        lines = []
        lines << @builder.label(k, class: 'control-label col-md-3')
        inp = @builder.text_field(nil, 
          input_html_options.merge(
              value: v, name: "#{object_name}[#{attribute_name}][][#{k}]"
          ).merge({ class: 'form-control' })
        )
        lines << template.content_tag(:div, inp, class: 'col-md-9')
        result << template.content_tag(:div, lines.join.html_safe, class: 'form-group')
      end
      name  = attribute_name.to_s.singularize
      con   = template.content_tag(:div, result.join.html_safe, class: 'volumes')
      head  = template.content_tag(:span, attribute_name, class: 'h3 panel-title')
      close = template.content_tag(:span, '', class: 'glyphicon glyphicon-remove')
      link  = template.link_to(close, '#', 'ng-click' => "delete('.#{name}', $event)", class: 'pull-right close')
      phead = template.content_tag(:div, head + link, class: 'panel-heading')
      pbody = template.content_tag(:div, con, class: 'panel-body')
      panel = template.content_tag(:div, phead + pbody, class: "panel panel-default #{name}")
    end.join.html_safe

    # result = []
    # ary.last.try(:each) do |k, v|
    #   lines = []
    #   lines << @builder.label(k, class: 'control-label col-md-3')
    #   inp = @builder.text_field(nil, 
    #     input_html_options.merge(
    #         value: '', name: "#{object_name}[#{attribute_name}][][#{k}]"
    #     ).merge({ class: 'form-control' })
    #   )
    #   lines << template.content_tag(:div, inp, class: 'col-md-9')
    #   result << template.content_tag(:div, lines.join.html_safe, class: 'form-group')
    # end
    # name  = attribute_name.to_s.singularize
    # con   = template.content_tag(:div, result.join.html_safe, class: 'volumes')
    # head  = template.content_tag(:span, attribute_name, class: 'h3 panel-title')
    # close = template.content_tag(:span, '', class: 'glyphicon glyphicon-remove')
    # link  = template.link_to(close, '#', 'ng-click' => "delete('.#{name}', $event)", class: 'pull-right close ng-hide')
    # phead = template.content_tag(:div, head + link, class: 'panel-heading')
    # pbody = template.content_tag(:div, con, class: 'panel-body')
    # panel = template.content_tag(:div, phead + pbody, class: "panel panel-default #{name}")
    # another = panel.html_safe

    # main + another
  end

  def input_type
    :text
  end
end
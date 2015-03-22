module ApplicationHelper
  @@per_page_max = 0

  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

  # def will_paginate(results)
  #   # next_page = (params[:page] || 0).to_i + 1
  #   # link_to "Next", "?page=#{next_page}"
  #   result = ""
  #   if results.length > @@per_page_max
  #     @@per_page_max = results.length
  #   end
  #   curr_page = (params[:page] || 0).to_i
  #   next_page = curr_page + 1

  #   if results.length >= @@per_page_max 
  #     result = "#{link_to 'Next', "?page=#{next_page}"}"  
  #     if curr_page > 0
  #       result += "|"
  #     end
  #   end

  #   if curr_page > 0
  #     prev_page = curr_page - 1
  #     result = result + " #{link_to "Prev", "?page=#{prev_page}"}"
  #   end   
  #   return result.html_safe
     
  # end

end
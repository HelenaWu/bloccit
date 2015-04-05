module ApplicationHelper
  def my_name
    "Helena Wu"
  end
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

  def up_vote_link_classes(post)
    vote = current_user.voted(post)
    "glyphicon glyphicon-chevron-up " +  ((vote && vote.up_vote?) ? 'voted' : '')
  end
  
  def down_vote_link_classes(post)
    vote = current_user.voted(post) 
    "glyphicon glyphicon-chevron-down " +  ((vote && vote.down_vote?) ? 'voted' : '')
  end
  
  # def will_paginate(results)
  #   result= ""
  #   if results.empty?
  #     total_count = 0
  #   else
  #     model_class = results.first.class
  #     total_count = model_class.count
  #   end
  #   curr_page = (params[:page] || 0).to_i
  #   per_page = results.per_page #call the per_page method we defined
  #   total_pages = total_count/per_page
  #   next_page = curr_page + 1
  #   prev_page = curr_page - 1

  #   if curr_page < total_pages
  #     result = "#{link_to 'Next', "?page=#{next_page}"}"  
  #    end

  #   if prev_page >0
  #     result = result + " #{link_to "Prev", "?page=#{prev_page}"}"
  #   end

  #   return result.html_safe 
  # end

end
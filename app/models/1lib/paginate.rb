module Paginate
  def paginate(options)
    per_page = options[:per_page]
    puts "==========>#{page}"
    puts "==========>#{per_page}"

    return (self.limit(per_page).offset(page*per_page))
  end
end
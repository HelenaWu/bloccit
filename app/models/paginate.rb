module Paginate

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def paginate(options)
      per_page = options[:per_page]
      page = (options[:page] || 0).to_i

      return self.limit(per_page).offset(page * per_page)
    end
  end
end
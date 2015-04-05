module Paginate

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def paginate(options)
      per_page_num = options[:per_page]
      page = (options[:page] || 0).to_i

      results = self.limit(per_page_num).offset(page * per_page_num)
      #Ruby allows dynamic definition of a method on an object
      def results.per_page
        per_page_num #Can't find this variable?
      end
      results
    end
  end
end
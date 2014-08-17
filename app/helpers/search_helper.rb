module SearchHelper

  def search_result_count(klass, results)

    if results.select{ |x| x.class.name.downcase == klass }.first.value == klass
      if results.select{ |x| x.class.name.downcase == klass }.first.results.count > 0
        return results.select{ |x| x.class.name.downcase}.first.results.count
      else
        return 0
      end
    end
  end
end

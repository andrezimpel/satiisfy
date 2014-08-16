module SearchHelper

  def search_result_count(klass, results)

    if results.select{ |x| x.first.class.name.downcase == klass }.to_a.first != nil
      return results.select{ |x| x.first.class.name.downcase == klass }.to_a.first.last.count
    else
      return 0
    end    
  end
end

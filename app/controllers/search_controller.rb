class SearchController < ApplicationController
  def index
    # view helper
    @search_query = params[:search] if params.has_key?(:search) # the search query
    @sidebar_elements = [["Projects", "project"], ["Questions", "question"], ["Users", "user"]]

    # run the search
    search_results = Sunspot.search Project, Question, User do
      fulltext params[:search]
      with :account_id, params[:account_id]
      with :klass, "question"

      paginate page: params[:page], per_page: 10
    end

    # prepare view variables

    @results = search_results.results
    @results_blank = search_results
    @results_count = search_results.total
    @results = @results.to_a
    @all_grouped_results = @results.group_by(&:class)
    @grouped_results = @all_grouped_results
    results = @results

    # filter results if a class is given
    if params.has_key?(:class)
      @all_grouped_results.each do |group, elements|
        # get the class name from the group
        class_name = elements.first.class.name.downcase

        if class_name != params[:class]
          # delete elements from array
          elements.each do |elem|
            results.delete(elem)
          end
        end
      end

      @results = results
    end

    # grouped results by a class
    @grouped_results = @results.group_by(&:class)
  end
end

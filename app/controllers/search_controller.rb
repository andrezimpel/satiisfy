class SearchController < ApplicationController
  def index
    # view helper
    @search_query = params[:search] if params.has_key?(:search) # the search query
    @sidebar_elements = [["Projects", "project"], ["Questions", "question"], ["Users", "user"]]

    # run the search
    search_results = Sunspot.search Project, Question, User do
      fulltext params[:search]
      with :account_id, params[:account_id]

      # scope class param
      if params.has_key?(:class)
        with :klass, params[:class]
      end

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

    # grouped results by a class
    @grouped_results = @results.group_by(&:class)
  end
end

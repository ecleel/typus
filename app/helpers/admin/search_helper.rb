module Admin

  module SearchHelper

    def search

      typus_search = @resource[:class].typus_defaults_for(:search)
      return if typus_search.empty?

      search_by = typus_search.collect { |x| @resource[:class].human_attribute_name(x) }.to_sentence

      search_params = params.dup
      %w( action controller search page id ).each { |p| search_params.delete(p) }

      hidden_params = search_params.map { |k, v| hidden_field_tag(k, v) }

      render "admin/helpers/search/search", 
             :hidden_params => hidden_params, 
             :search_by => search_by

    end

  end

end
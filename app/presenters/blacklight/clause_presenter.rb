# frozen_string_literal: true

module Blacklight
  class ClausePresenter
    attr_reader :user_parameters, :field_config, :view_context, :search_state

    def initialize(user_parameters, field_config, view_context, search_state = view_context.search_state)
      @user_parameters = user_parameters
      @field_config = field_config
      @view_context = view_context
      @search_state = search_state
    end

    def key
      user_parameters[:field]
    end

    def field_label
      field_config.display_label('search')
    end

    ##
    # Get the displayable version of a facet's value
    #
    # @return [String]
    def label
      user_parameters[:query]
    end

    def href(_path_options = {})
      remove_href
    end

    # @private
    def remove_href(path = search_state)
      params = path.except(:clause)
      params[:clause] = path[:clause].reject { |_k, v| v[:field] == user_parameters[:field] }
      view_context.search_action_path(params)
    end

    private

    def facet_field_presenter
      @facet_field_presenter ||= view_context.facet_field_presenter(facet_config, {})
    end
  end
end

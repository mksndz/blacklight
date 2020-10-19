# frozen_string_literal: true

module Blacklight
  class InclusiveFacetItemPresenter < Blacklight::FacetItemPresenter
    attr_reader :facet_item, :facet_config, :view_context, :search_state, :facet_field

    delegate :hits, :items, to: :facet_item

    def initialize(facet_item, facet_config, view_context, facet_field, search_state = view_context.search_state)
      @facet_item = facet_item
      @facet_config = facet_config
      @view_context = view_context
      @facet_field = facet_field
      @search_state = search_state
    end

    ##
    # Check if the query parameters have the given facet field with the
    # given value.
    def selected?
      true
    end

    ##
    # Get the displayable version of a facet's value
    #
    # @return [String]
    def label
      view_context.safe_join(
        values.map { |value| Blacklight::FacetItemPresenter.new(value, facet_config, view_context, facet_field, search_state).label },
        ' OR '
      )
    end

    def values
      facet_item
    end

    def href(_path_options = {})
      remove_href
    end

    # @private
    def remove_href(path = search_state)
      params = values.inject(path) { |p, v| path.reset(p.remove_facet_params(facet_config.key, v, param: :f_inclusive)) }
      view_context.search_action_path(params)
    end

    # @private
    def add_href(path_options = {})
      nil
    end

    private

    def facet_field_presenter
      @facet_field_presenter ||= view_context.facet_field_presenter(facet_config, {})
    end
  end
end

# frozen_string_literal: true

module Blacklight
  class FacetFieldInclusiveConstraintComponent < ::ViewComponent::Base
    with_collection_parameter :facet_field

    def initialize(facet_field:)
      @facet_field = facet_field
    end

    def values
      return [] unless @facet_field.search_state&.inclusive_filter_params&.key?(@facet_field.key)

      @facet_field.search_state.inclusive_filter_params[@facet_field.key]
    end

    def render?
      values.present?
    end

    def presenters
      return to_enum(:presenters) unless block_given?

      values.each do |v|
        yield Blacklight::FacetItemPresenter.new(v, @facet_field.facet_field, @view_context, @facet_field.key, param_key: :f_inclusive)
      end
    end
  end
end

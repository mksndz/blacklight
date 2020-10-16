# frozen_string_literal: true

module Blacklight
  class FacetFieldCheckboxesComponent < ::ViewComponent::Base
    def initialize(facet_field:, layout: nil)
      @facet_field = facet_field
      @layout = layout == false ? FacetFieldNoLayoutComponent : Blacklight::FacetFieldComponent
    end

    def render?
      @facet_field.paginator.items.any?
    end
  end
end

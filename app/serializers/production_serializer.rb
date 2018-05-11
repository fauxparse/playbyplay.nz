# frozen_string_literal: true

class ProductionSerializer < Primalize::Single
  attributes(
    id: integer,
    name: string,
    slug: string
  )
end

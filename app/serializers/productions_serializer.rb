# frozen_string_literal: true

class ProductionsSerializer < Primalize::Many
  attributes productions: enumerable(ProductionSerializer)
end

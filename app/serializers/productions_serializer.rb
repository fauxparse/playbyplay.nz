# frozen_string_literal

class ProductionsSerializer < Primalize::Many
  attributes productions: enumerable(ProductionSerializer)
end

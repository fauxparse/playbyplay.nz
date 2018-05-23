# frozen_string_literal: true

class ReviewForm
  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment

  attr_reader :review

  validates :text, :production, :performance_date, presence: true

  def initialize(review, attributes = {})
    @review = review
    self.attributes = attributes
  end

  def attributes=(attributes)
    super sanitize_attributes(attributes)
  end

  def update(attributes = {})
    self.attributes = attributes
    save
  end

  def save
    production.save if production&.changed?
    valid? && review.save
  end

  def to_model
    review
  end

  delegate(
    :performance_date,
    :performance_date=,
    :production,
    :production_id,
    :production_id=,
    :text,
    :text=,
    to: :review
  )

  def production=(attributes)
    if attributes[:id].present?
      update_and_assign_production(
        Production.find(attributes[:id]),
        attributes.except(:id)
      )
    else
      review.build_production(attributes)
    end
  end

  def dates
    (0...7).map { |d| d.days.ago.to_date }
  end

  private

  def update_and_assign_production(production, attributes)
    if attributes.all? { |attr, value| production.send(attr) == value }
      review.production = production
    elsif production.reviews.to_a == [review]
      production.attributes = attributes
      review.production = production
    else
      review.build_production(attributes)
    end
  end

  def sanitize_attributes(attributes)
    return attributes || {} unless attributes.respond_to?(:permit)
    attributes.permit(
      :text,
      :performance_date,
      production: %i[name id]
    )
  end
end

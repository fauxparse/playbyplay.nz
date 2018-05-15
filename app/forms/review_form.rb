# frozen_string_literal: true

class ReviewForm
  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment

  attr_reader :review

  validates :text, :production, :performance_date, presence: true

  def initialize(review)
    @review = review
  end

  def update(attributes = {})
    self.attributes = sanitize_attributes(attributes)
    save
  end

  def save
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
    if attributes[:id]
      review.production_id = attributes[:id]
    else
      review.build_production(attributes)
    end
  end

  def dates
    (0...7).map { |d| d.days.ago.to_date }
  end

  private

  def sanitize_attributes(attributes)
    return attributes unless attributes.respond_to?(:permit)
    attributes.permit(
      :text,
      :performance_date,
      production: %i[name id]
    )
  end
end

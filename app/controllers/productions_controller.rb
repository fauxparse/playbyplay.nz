# frozen_string_literal: true

class ProductionsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: production_serializer.call }
    end
  end

  private

  def production_serializer
    ProductionsSerializer.new(productions: productions.to_a)
  end

  def productions
    @productions ||=
      if params[:query].present?
        Productions.new(params)
      else
        []
      end
  end
end

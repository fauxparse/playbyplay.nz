# frozen_string_literal: true

module ButtonsHelper
  def button(options = {})
    content_tag :button, button_options(options) do
      concat button_left_icon(options)
      concat button_text(options)
      yield if block_given?
      concat button_right_icon(options)
    end
  end

  private

  def button_options(options)
    options
      .except(:class, :icon, :icon_position, :text)
      .merge(class: button_class(options))
  end

  def button_class(options)
    class_string('button', options[:class])
  end

  def button_left_icon(options)
    button_icon(options) unless options[:icon_position] == :right
  end

  def button_right_icon(options)
    button_icon(options) if options[:icon_position] == :right
  end

  def button_icon(options)
    options[:icon] &&
      inline_svg("icons/#{options[:icon]}", class: 'button__icon')
  end

  def button_text(options)
    options[:text] && content_tag(:div, options[:text], class: 'button__text')
  end
end

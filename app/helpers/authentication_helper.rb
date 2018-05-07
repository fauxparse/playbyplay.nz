# frozen_string_literal: true

module AuthenticationHelper
  def authenticated_link_to(*args, &block)
    options = args.extract_options!
    options.deep_merge!(authenticated_link_options) unless logged_in?
    link_to(*args, options, &block)
  end

  private

  def authenticated_link_options
    { data: { controller: 'login', action: 'login#show' } }
  end
end

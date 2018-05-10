SimpleCov.start('rails') do
  add_filter do |source_file|
    source_file.lines.count < 7
  end

  add_group 'Forms', 'app/forms'
  add_group 'Queries', 'app/queries'
  add_group 'Services', 'app/services'
end

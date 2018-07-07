def base_path
  return unless ENV['RAILS_ENV']
  '/stackeye'
end

def titleize(str)
  str.tr('_', ' ').capitalize
end

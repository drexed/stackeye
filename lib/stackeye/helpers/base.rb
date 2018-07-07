def base_path
  return unless ENV['RAILS_ENV']
  '/stackeye'
end

def path_to(path)
  "#{base_path}/path"
end

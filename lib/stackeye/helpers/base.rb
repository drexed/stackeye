def base_path
  return unless ENV['RAILS_ENV']

  '/stackeye'
end

def page?(path)
  request.path == "#{base_path}#{path}"
end

def refreshing?
  cookies[:refresh] == '1'
end

def titleize(str)
  str.tr('_', ' ').capitalize
end

def verified_distro?
  Stackeye::Tools::Os.linux?
end

def verified_os?
  cmd = 'lsb_release -ds'
  Stackeye::Tools::Cli.execute(cmd).strip.include?('Ubuntu')
end

def verify_distro_and_os?
  verified_distro? && verified_os?
end

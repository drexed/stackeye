# frozen_string_literal: true

def base_path
  return unless ENV['RAILS_ENV']

  '/stackeye'
end

def metric_icon_decorator(metric)
  case metric
  when 'server' then 'server'
  else 'database'
  end
end

def metric_name_decorator(metric)
  case metric
  when 'mysql' then 'MySQL'
  else titleize(metric)
  end
end

def modulize(str)
  str.tr('_-', ' ').split(' ').map(&:capitalize).join('')
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

def verified_distro_and_os?
  verified_distro? && verified_os?
end

def verify_distro_and_os!
  return if verified_distro_and_os?

  redirect("#{base_path}/unsupported")
end

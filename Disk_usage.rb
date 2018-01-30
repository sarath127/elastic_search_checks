#checking disk usage



require 'sensu-plugin/check/cli'

class ESHeap < Sensu::Plugin::Check::CLI

  option :warn,
          short: '-w PERCENT',
          description: 'Warn if PERCENT or more of disk full',
          proc: proc(&:to_i),
          default: 85

   option :crit,
          short: '-c PERCENT',
          description: 'Critical if PERCENT or more of disk full',
          proc: proc(&:to_i),
          default: 95

def run

  fs_to_check = '/boot'
  df_output = `df #{fs_to_check} `
  disk_line = df_output.split(/\n/)[1]
  disk_free_bytes = disk_line.match(/(.+)\s+(\d+)\s+(\d+)\s+(\d+)\s+/)[4].to_i
  disk_used_bytes = disk_line.match(/(.+)\s+(\d+)\s+(\d+)\s+(\d+)\s+/)[3].to_i
  totel=disk_free_bytes+disk_used_bytes
  disk_usage=100*disk_used_bytes/totel
    if disk_usage >= config[:crit]
      critical
    elsif disk_usage >= config[:warn]
      warning
    else
      ok
    end
  end
end

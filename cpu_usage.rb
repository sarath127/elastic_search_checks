#checking cpu usage
#dependencies:
#            gems:: sensu plugin ,usagewatch_ext
require 'usagewatch_ext'
require 'sensu-plugin/check/cli'

class ESHeap < Sensu::Plugin::Check::CLI

  option :warn,
          short: '-w PERCENT',
          description: 'Warn if PERCENT or more of cpu memory full',
          proc: proc(&:to_i),
          default: 80

   option :crit,
          short: '-c PERCENT',
          description: 'Critical if PERCENT or more of cpu memory full',
          proc: proc(&:to_i),
          default: 90

def run
  usw = Usagewatch
  cpu_usage=usw.uw_cpuused
  puts cpu_usage
    if cpu_usage >= config[:crit]
      critical
    elsif cpu_usage >= config[:warn]
      warning
    else
      ok
    end
  end
end

require 'json'
require 'sensu-plugin/check/cli'

class ESHeap < Sensu::Plugin::Check::CLI

option :warn,
        short: '-w N',
        description: 'Totel time spent on flushing WARNING threshold',
        long: '--warn N',
        proc: proc(&:to_i),
        default: 42

option :crit,
        short: '-c N',
        long: '--crit N',
        description: 'Totel time spent on flushing CRITICAL threshold',
        proc: proc(&:to_i),
        default: 42

def run
file = File.read('stat.json')
json = JSON.parse(file)
time_spent_on_flushing=json['nodes']['7Q7a93qpRl6eNicsNa73cg']['indices']['flush']['total_time_in_millis'].to_i
  puts time_spent_on_flushing
    if time_spent_on_flushing > config[:crit]
      critical
    elsif time_spent_on_flushing >= config[:warn]
      warning
    else
      ok
    end
  end
end

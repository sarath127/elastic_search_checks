require 'json'
require 'sensu-plugin/check/cli'

class ESHeap < Sensu::Plugin::Check::CLI

option :warn,
        short: '-w N',
        description: 'Totel time spent on indexing WARNING threshold',
        long: '--warn N',
        proc: proc(&:to_i),
        default: 185

option :crit,
        short: '-c N',
        long: '--crit N',
        description: 'Totel time spent on indexing CRITICAL threshold',
        proc: proc(&:to_i),
        default: 192

def run
file = File.read('stat.json')
json = JSON.parse(file)
time_spent_on_indexing=json['nodes']['7Q7a93qpRl6eNicsNa73cg']['indices']['indexing']['index_time_in_millis'].to_i
  puts time_spent_on_indexing
    if time_spent_on_indexing>= config[:crit]
      critical
    elsif time_spent_on_indexing >= config[:warn]
      warning
    else
      ok
    end
  end
end

require 'json'
require 'sensu-plugin/check/cli'

class ESHeap < Sensu::Plugin::Check::CLI

option :warn,
        short: '-w N',
        description: 'Totel time spent on young generation garbage collection WARNING threshold',
        long: '--warn N',
        proc: proc(&:to_i),
        default: 7412

option :crit,
        short: '-c N',
        long: '--crit N',
        description: 'Totel time spent on young generation garbage collection CRITICAL threshold',
        proc: proc(&:to_i),
        default: 7412

def run
file = File.read('stat.json')
json = JSON.parse(file)
time_spent_on_young_generation_garbage_collection=json['nodes']['7Q7a93qpRl6eNicsNa73cg']['jvm']['gc']['collectors']['young']['collection_time_in_millis'].to_i
  puts time_spent_on_young_generation_garbage_collection
    if time_spent_on_young_generation_garbage_collection> config[:crit]
      critical
    elsif time_spent_on_young_generation_garbage_collection >= config[:warn]
      warning
    else
      ok
    end
  end
end

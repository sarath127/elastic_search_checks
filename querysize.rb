
#   checking totel number of queries
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem:json
require 'json'
require 'sensu-plugin/check/cli'

class ESHeap < Sensu::Plugin::Check::CLI
option :warn1,
        short: '-w N',
        long: '--warn N',
        description: 'totel no of queries WARNING threshold',
        proc: proc(&:to_i),
        default: 26

option :crit1,
        short: '-c N',
        long: '--crit N',
        description: 'Totel no of queries CRITICAL threshold',
        proc: proc(&:to_i),
        default: 28


def run
file = File.read('stat.json')
json = JSON.parse(file)
query_total=json['nodes']['7Q7a93qpRl6eNicsNa73cg']['indices']['search']['query_total'].to_i
  puts query_total
    if query_total >= config[:crit1]
      puts critical
    elsif query_total >= config[:warn1]
      puts warning
    else
      ok
    end
  end
end

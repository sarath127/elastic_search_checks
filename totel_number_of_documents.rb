require 'json'
require 'sensu-plugin/check/cli'

class ESHeap < Sensu::Plugin::Check::CLI

option :warn,
        short: '-w N',
        description: 'Totel number of Documents WARNING threshold',
        long: '--warn N',
        proc: proc(&:to_i),
        default: 100

option :crit,
        short: '-c N',
        long: '--crit N',
        description: 'Totel number of Documents CRITICAL threshold',
        proc: proc(&:to_i),
        default: 150

def run
file = File.read('stat.json')
json = JSON.parse(file)
total_number_of_documents=json['nodes']['7Q7a93qpRl6eNicsNa73cg']['indices']['indexing']['index_total'].to_i
  puts total_number_of_documents
    if total_number_of_documents>= config[:crit]
      critical
    elsif total_number_of_documents >= config[:warn]
      warning
    else
      ok
    end
  end
end

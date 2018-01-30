#checking Number of documents currently being indexed
#dependencies:
#            gems:: sensu plugin

require 'json'
require 'sensu-plugin/check/cli'

class ESHeap < Sensu::Plugin::Check::CLI

option :warn,
        short: '-w N',
        description: 'Number of documents currently being indexed	 WARNING threshold',
        long: '--warn N',
        proc: proc(&:to_i),
        default: 10

option :crit,
        short: '-c N',
        long: '--crit N',
        description: 'Number of documents currently being indexed	 CRITICAL threshold',
        proc: proc(&:to_i),
        default: 10

def run

file = File.read('stat.json')
json = JSON.parse(file)
No_of_Documents_currently_being_indexed=json['nodes']['7Q7a93qpRl6eNicsNa73cg']['indices']['indexing']['index_current'].to_i
    puts No_of_Documents_currently_being_indexed
      if No_of_Documents_currently_being_indexed > config[:crit]
         critical
      elsif No_of_Documents_currently_being_indexed >= config[:warn]
         warning
      else
      ok
    end
  end
end

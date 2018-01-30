#! /usr/bin/env ruby
#
#   search-performance-metrics
#
# DESCRIPTION:
#   This plugin checks ElasticSearch's search performance metrics using its API.
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem:json
require 'json'
require 'sensu-plugin/check/cli'

class ESHeap < Sensu::Plugin::Check::CLI

option :warn,
        short: '-w N',
        description: 'Totel time spent on queries WARNING threshold',
        long: '--warn N',
        proc: proc(&:to_i),
        default: 185

option :crit,
        short: '-c N',
        long: '--crit N',
        description: 'Totel time spent on queries CRITICAL threshold',
        proc: proc(&:to_i),
        default: 192

def run
file = File.read('stat.json')
json = JSON.parse(file)
time_spent_on_queries=json['nodes']['7Q7a93qpRl6eNicsNa73cg']['indices']['search']['query_time_in_millis'].to_i
  puts time_spent_on_queries
    if time_spent_on_queries>= config[:crit]
      critical
    elsif time_spent_on_queries >= config[:warn]
      warning
    else
      ok
    end
  end
end

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
        long: '--warn N',
        description: 'Totel number of fetches WARNING threshold',
        proc: proc(&:to_i),
        default: 0

option :crit,
        short: '-c N',
        long: '--crit N',
        description: 'Totel number of fetches CRITICAL threshold',
        proc: proc(&:to_i),
        default: 0

def run
file = File.read('stat.json')
json = JSON.parse(file)
fetch_current_work=json['nodes']['7Q7a93qpRl6eNicsNa73cg']['indices']['search']['fetch_current'].to_i
    puts fetch_current_work
      if fetch_current_work > config[:crit]
        critical
      elsif fetch_current_work > config[:warn]
        warning
      else
        ok
      end
  end
end

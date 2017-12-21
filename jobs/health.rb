#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'httparty'
require 'ap'

#
### Global Config
#
# httptimeout => Number in seconds for HTTP Timeout. Set to ruby default of 60 seconds.
# ping_count => Number of pings to perform for the ping method
#
HTTP_TIMEOUT = 60
PING_COUNT = 10

#
# Check whether a server is Responding you can set a server to
# check via http request or ping
#
# Server Options
#   name
#       => The name of the Server Status Tile to Update
#   url
#       => Either a website url or an IP address. Do not include https:// when using ping method.
#   method
#       => http
#       => ping
#
# Notes:
#   => If the server you're checking redirects (from http to https for example)
#      the check will return false
#

servers = [
  { name: 'new-tech-dev', url: 'http://delius-new-tech.eu-west-2.elasticbeanstalk.com' },
  { name: 'new-tech-stage', url: 'http://delius-new-tech-stage.eu-west-2.elasticbeanstalk.com' },
  { name: 'new-tech-prod', url: 'http://delius-new-tech-prod.eu-west-2.elasticbeanstalk.com' },
  { name: 'pdf-gen-dev', url: 'http://pdf-generator.eu-west-2.elasticbeanstalk.com' },
  { name: 'pdf-gen-stage', url: 'http://pdf-generator-stage.eu-west-2.elasticbeanstalk.com' },
  { name: 'pdf-gen-prod', url: 'http://pdf-generator-prod.eu-west-2.elasticbeanstalk.com' },
]

def gather_health_data(server)

  begin
    response_health = HTTParty.get("#{server[:url]}/healthcheck", headers: { 'Accept' => 'application/json' }, timeout: 5)
    return response_health
  rescue HTTParty::Error => expection
    ap expection.class
    return { status: 'error', version: expection.class }
  rescue StandardError => expection
    ap expection.class
    return { status: 'error', version: expection.class }
  end
end

SCHEDULER.every '60s', first_in: 0 do |_job|
  servers.each do |server|
    result = gather_health_data(server)
    send_event(server[:name], result: result)
  end
end
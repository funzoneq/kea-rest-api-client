require 'pp'
require 'httparty'

class KEARestApiClient
    include HTTParty
    base_uri '64.201.245.207:8080'

    def command(command, service = [ 'dhcp4' ], arguments = {})
        body = {
            "command": command,
            "service": service,
            "arguments": arguments
        }

        self.class.post("/", :body => body.to_json, :headers => { 'Content-Type' => 'application/json' } )
    end

    def build_report
        self.command("build-report", ['dhcp4', 'dhcp6'])
    end

    def config_get
        self.command("config-get", ['dhcp4', 'dhcp6'])
    end

    def list_commands
        self.command("list-commands", ['dhcp4', 'dhcp6'])
    end

    def statistics_get_all
        self.command("statistic-get-all", ['dhcp4', 'dhcp6'])
    end
end

k = KEARestApiClient.new()
pp k.statistics_get_all

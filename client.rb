require 'pp'
require 'httparty'

class KEARestApiClient
    include HTTParty
    base_uri '64.201.245.207:8080'

    def command(command, service = [ 'dhcp4' ], arguments = {})
        body = {
            "command": command,
            "service": service
        }

        if arguments != {}
            body['arguments'] = arguments
        end

        self.class.post("/", :body => body.to_json, :headers => { 'Content-Type' => 'application/json' } )
    end

    def build_report
        self.command("build-report", ['dhcp4', 'dhcp6'])
    end

    def config_get
        self.command("config-get", ['dhcp4', 'dhcp6'])
    end

    def config_reload
        self.command("config-reload", ['dhcp4', 'dhcp6'])
    end

    def config_set
        self.command("config-set", ['dhcp4', 'dhcp6'])
    end

    def subnet4_list
        self.command("subnet4-list", ['dhcp4'])
    end

    def network4_list
        self.command("network4-list", ['dhcp4'])
    end

    def lease4_get(type, identifier, subnet_id)
        if not ['address', 'hw-address', 'duid', 'client-id'].include?(type)
           return "type #{type} is not valid"
        end

        self.command("lease4-get", ['dhcp4'], { "identifier-type": type, "identifier": identifier, "subnet-id": subnet_id })
    end

    def lease4_get_by_mac(hw_address, subnet_id)
        self.lease4_get("hw-address", hw_address, subnet_id)
    end

    def lease4_get_by_ip(address)
        self.command("lease4-get", ['dhcp4'], { "ip-address": address })
    end

    def lease4_get_all
        self.command("lease4-get-all", ['dhcp4'])
    end

    def dhcp_disable
        self.command("dhcp-disable", ['dhcp4'])
    end

    def dhcp_enable
        self.command("dhcp-enable", ['dhcp4'])
    end

    def shutdown
        self.command("shutdown", ['dhcp4'])
    end

    def list_commands
        self.command("list-commands", ['dhcp4', 'dhcp6'])
    end

    def statistics_get_all
        self.command("statistic-get-all", ['dhcp4', 'dhcp6'])
    end
end

k = KEARestApiClient.new()
# pp k.list_commands
#pp k.shutdown
#pp k.build_report
pp k.lease4_get_all
#pp k.network4_list
#pp k.lease4_get("bla", "asd", 1)
#pp k.lease4_get_by_mac("70:88:6b:85:d8:a5", 1)
pp k.lease4_get_by_ip("148.64.116.10")

# kea-rest-api-client
A ruby library to interact with the Kea DHCP Server REST API

## Required configuration

Enable the [REST API on Kea](https://gitlab.isc.org/isc-projects/kea/wikis/designs/commands) with this snippet:

In /etc/kea/kea-ctrl-agent.conf edit this:
```
// This is a basic configuration for the Kea Control Agent.
// RESTful interface to be available at http://0.0.0.0:8080/
"Control-agent": {
    "http-host": "0.0.0.0",
    "http-port": 8080,

    // Specify location of the files to which the Control Agent
    // should connect to forward commands to the DHCPv4 and DHCPv6
    // server via unix domain socket.
    "control-sockets": {
        "dhcp4": {
            "socket-type": "unix",
            "socket-name": "/tmp/kea-dhcp4-ctrl.sock"
        },
        "dhcp6": {
            "socket-type": "unix",
            "socket-name": "/tmp/kea-dhcp6-ctrl.sock"
        }
    }
}
```

Make sure your kea-dhcp4 and kea-dhcp6.conf include:
- the socket
- load the hooks

```
{
    "Dhcp4": {
        // Add names of your network interfaces to listen on.
        "interfaces-config": {
            "interfaces": [ "eth0", "eth1" ]
        },

        "control-socket": {
            "socket-type": "unix",
            "socket-name": "/tmp/kea-dhcp4-ctrl.sock"
        },

        // For a list of available hook libraries, see https://gitlab.isc.org/isc-projects/kea/wikis/Hooks-available
        "hooks-libraries": [
            {
                "library": "/usr/lib64/hooks/libdhcp_host_cmds.so"
            },
            {
                "library": "/usr/lib64/kea/hooks/libdhcp_lease_cmds.so"
            },
            {
                "library": "/usr/lib64/kea/hooks/libdhcp_stat_cmds.so"
            }
        ]
    }
}
```

## Usage

```ruby
require 'pp'
k = KEARestApiClient.new('172.16.1.1:8080')
```

Get the config:
```ruby
pp k.config_get
```

Get all DHCPv4 leases:
```ruby
pp k.lease4_get_all
```

Get a lease by mac address or ip address:
```ruby
pp k.lease4_get_by_mac("70:88:6b:85:d8:a5", 2)
pp k.lease4_get_by_ip("172.16.0.1")
```

Get all DHCPv6 leases:
```ruby
pp k.lease6_get_all
```

Get a lease by ip address or DUID:
```ruby
pp k.lease6_get_by_ip("2001:0DB8::47")
pp k.lease6_get_by_duid("00:01:00:01:23:86:cc:fa:70:88:6b:85:d8:a5", 1)
```

Add a reservation
```ruby
pp k.reservation_add({"hostname"=>"cpe-6405513318001608", "hw-address"=>"00:1e:80:60:cb:6d", "ip-address"=>"172.16.1.170", "subnet-id"=>2})
```

Get a reservation:
```ruby
pp k.reservation_get_by_address("172.16.1.170", 2)
```

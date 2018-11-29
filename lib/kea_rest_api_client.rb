require 'httparty'

class KEARestApiClient
  include HTTParty
  base_uri '64.201.245.219:8080'

  def command(command, service = ['dhcp4'], arguments = {})
    body = {
      'command' => command,
      'service' => service
    }

    body['arguments'] = arguments if arguments != {}

    self.class.post('/', body: body.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def build_report
    command('build-report', %w[dhcp4 dhcp6])
  end

  def config_get
    command('config-get', %w[dhcp4 dhcp6])
  end

  def config_reload
    command('config-reload', %w[dhcp4 dhcp6])
  end

  def config_set
    command('config-set', %w[dhcp4 dhcp6])
  end

  def config_test
    command('config-test', %w[dhcp4 dhcp6])
  end

  def config_write
    command('config-write', %w[dhcp4 dhcp6])
  end

  def dhcp_disable
    command('dhcp-disable', %w[dhcp4 dhcp6])
  end

  def dhcp_enable
    command('dhcp-enable', %w[dhcp4 dhcp6])
  end

  def shutdown
    command('shutdown', %w[dhcp4 dhcp6])
  end

  def list_commands
    command('list-commands', %w[dhcp4 dhcp6])
  end

  def statistics_get_all
    command('statistic-get-all', %w[dhcp4 dhcp6])
  end

  def statistic_remove_all
    command('statistic-remove-all', %w[dhcp4 dhcp6])
  end

  def statistic_reset_all
    command('statistic-reset-all', %w[dhcp4 dhcp6])
  end

  ### DHCPv4 Specific commands
  def subnet4_list
    command('subnet4-list', ['dhcp4'])
  end

  def network4_list
    command('network4-list', ['dhcp4'])
  end

  def lease4_get(type, identifier, subnet_id)
    return "type #{type} is not valid" unless ['address', 'hw-address', 'client-id'].include?(type)

    command('lease4-get', ['dhcp4'], 'identifier-type' => type, 'identifier' => identifier, 'subnet-id' => subnet_id)
  end

  def lease4_get_by_mac(hw_address, subnet_id)
    lease4_get('hw-address', hw_address, subnet_id)
  end

  def lease4_get_by_ip(address)
    command('lease4-get', ['dhcp4'], 'ip-address' => address)
  end

  def lease4_get_all
    command('lease4-get-all', ['dhcp4'])
  end

  ### DHCPv6 Specific commands
  def lease6_get_all
    command('lease6-get-all', ['dhcp6'])
  end

  def lease6_get(type, identifier, subnet_id)
    return "type #{type} is not valid" unless ['address', 'duid', 'client-id'].include?(type)

    command('lease6-get', ['dhcp6'], 'identifier-type' => type, 'identifier' => identifier, 'subnet-id' => subnet_id)
  end

  def lease6_get_by_duid(duid, subnet_id)
    lease6_get('duid', duid, subnet_id)
  end

  def lease6_get_by_ip(address)
    command('lease6-get', ['dhcp6'], 'ip-address' => address)
  end
end

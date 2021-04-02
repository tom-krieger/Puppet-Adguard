# Tests applying adguard with basic DHCP options
require 'spec_helper_acceptance'

pp_dhcp = <<-MANIFEST
    class {'adguard':
        users => [
          {
              username => 'user',
              password => '$2y$10$c6lDDShTh5ezcvKhyWwOMet6C/0tLxlgYX53wf58jl9tBdUVbYSqe',
          }],
        enable_dhcp => true,
        dhcp_interface => 'eth0',
        dhcp_v4_options => {
            gateway_ip => '192.168.1.1',
            subnet_mask => '255.255.255.0',
            range_start => '192.168.1.2',
            range_end => '192.168.1.20',
            lease_duration => 86400,
        }
    }
MANIFEST

idempotent_apply(pp_dhcp)

describe 'adguard_dhcp' do
  context service('AdGuardHome') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
  context file('/opt/AdGuardHome/AdGuardHome.yaml') do
    it { is_expected.to be_file }
    its(:content) { is_expected.to match(%r{gateway_ip: 192.168.1.1}).and match(%r{subnet_mask: 255.255.255.0}) }
  end
end

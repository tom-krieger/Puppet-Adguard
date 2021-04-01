# Basic tests applicable to all operating systems.
require 'spec_helper_acceptance'

pp_basic = <<-MANIFEST
    class {'adguard':
        users => [
          {
              username => 'user',
              password => '$2y$10$c6lDDShTh5ezcvKhyWwOMet6C/0tLxlgYX53wf58jl9tBdUVbYSqe',
          }],
        enable_dhcp => true,
        interface_name => 'eth0',
        dhcp_v4_options => {
          gateway_ip => '192.168.1.1',
          subnet_mast => '255.255.255.0',
          range_start => '192.168.1.2',
          range_end => '192.168.1.10',
          lease_duration => 86400,
        }
    }
MANIFEST

idempotent_apply(pp_basic)

describe 'adguard_basic' do
  context service('AdGuardHome') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
  context file('/opt/AdGuardHome/AdGuardHome.yaml') do
    it { is_expected.to be_file }
    its(:content) { is_expected.to match(%r{\$2y\$10\$c6lDDShTh5ezcvKhyWwOMet6C\/0tLxlgYX53wf58jl9tBdUVbYSqe}).and match(%r{gateway_ip: "192.168.1.1"}) }
  end
  # Ensure our ports are listening
  context port(80) do
    it { is_expected.to be_listening }
  end
  context port(53) do
    it { is_expected.to be_listening }
  end
end

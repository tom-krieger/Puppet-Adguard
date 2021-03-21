# Only applicable to systemd, ensure that resolved is not listening.
require_relative 'adguard_spec'

describe 'adguard_deb', if: ['debian', 'ubuntu'].include?(os[:family]) do
  context file('/etc/systemd/resolved.conf') do
    its(:content) { is_expected.to match %r{DNSStubListener=no} }
  end
end
